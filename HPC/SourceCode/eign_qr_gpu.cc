//Source reference: https://github.com/zjevik/QR-decomposition

#include <cassert>
#include <cstdlib>
#include <iomanip>
#include <iostream>
#include <vector>
#include <cudalicious/blas.hpp>
#include <cudalicious/core.hpp>
#include <cudalicious/solver.hpp>
#include "papi.h"

#define NUM_EVENTS 4
int event[NUM_EVENTS]={PAPI_L1_DCM,PAPI_L1_ICM,PAPI_L2_DCM,PAPI_L2_ICM};
//int event[NUM_EVENTS]={PAPI_L3_DCM,PAPI_L3_ICH,PAPI_LD_INS,PAPI_TOT_INS};
long long values[NUM_EVENTS];
constexpr auto MAX_ITER = 50;

struct Eigensystem {
const std::vector<float> eigenvectors;
const std::vector<float> eigenvalues;
Eigensystem(const std::vector<float>& eigenvectors, const std::vector<float>& eigenvalues)
: eigenvectors(eigenvectors)
, eigenvalues(eigenvalues)
{}
};
template<typename T>
void print_matrix(const std::vector<T>& matrix, const int n)
{
for (auto i = 0; i < n; ++i) {
for (auto j = 0; j < n; ++j) {
const auto idx = j * n + i;
std::cout « std::setprecision(7) « std::setw(12) « matrix[idx];
}
std::cout« "\n";
}

}
__device__
float get_reflector_coefficient(const float* source, const float* tau, const int n, const int
,! reflector_index, const int row, const int col)
{
if (row < reflector_index || col < reflector_index) return (row == col) ? 1.f : 0.f;
const auto row_coeff = (row == reflector_index) ? 1.f : source[reflector_index * n + row];
const auto col_coeff = (col == reflector_index) ? 1.f : source[reflector_index * n + col];
return ((row == col) ? 1.f : 0.f) - tau[reflector_index] * row_coeff * col_coeff;
}
__global__
void construct_q_matrix(float* q, const float* source, const float* tau, const size_t n)
{
// Remember that `x` gives the row index, and `y` gives the column index.
const auto row = blockDim.x * blockIdx.x + threadIdx.x;
const auto col = blockDim.y * blockIdx.y + threadIdx.y;
const auto idx = col * n + row;
if (row >= n || col >= n) return;
for (auto k = 0U; k < n; ++k) {
auto inner_product = 0.f;
for (auto i = 0U; i < n; ++i) {
const auto row_coefficient = q[i * n + row];
const auto col_coefficient = get_reflector_coefficient(source, tau, n, k, i, col);
inner_product += row_coefficient * col_coefficient;
}
__syncthreads();
q[idx] = inner_product;
}
}
Eigensystem compute_eigensystem(const std::vector<float>& matrix, const size_t n)
{
assert(matrix.size() == n * n); // Ensure matrix is square
if (n > 32U) {
std::cerr « "Maximum supported matrix size is 32x32!\n";
std::exit(1);
}
const dim3 threads_per_block(32, 32);
const dim3 block_size(
std::ceil(n / threads_per_block.x) + (((n % threads_per_block.x) == 0 ? 0 : 1)),
std::ceil(n / threads_per_block.y) + (((n % threads_per_block.y) == 0 ? 0 : 1))

);
// Create cuSOLVER and cuBLAS handles.
auto solver_handle = cuda::solver::initialize();
auto blas_handle = cuda::blas::initialize();
// Allocate device memory.
auto dev_matrix = cuda::copy_to_device(matrix);
auto dev_qr = cuda::allocate<float>(matrix.size());
cuda::copy_on_device(dev_qr, dev_matrix, matrix.size());
// Determine workspace size.
auto workspace_size = cuda::solver::geqrf_buffer_size(solver_handle, n, n, dev_matrix, n);
auto dev_tau = cuda::allocate<float>(n);
auto dev_workspace = cuda::allocate<float>(workspace_size);
auto dev_info = cuda::allocate<int>(1);
std::vector<float> identity(n * n, 0);
for (auto i = 0U; i < n; ++i) {
identity[i * n + i] = 1.f;
}
auto dev_q = cuda::copy_to_device(identity);
auto dev_eigvecs = cuda::copy_on_device(dev_q, matrix.size());
for (auto iter = 0; iter < MAX_ITER; ++iter) {
// Compute QR factorization.
cuda::solver::geqrf(solver_handle, n, n, dev_qr, n, dev_tau, dev_workspace,
,! workspace_size, dev_info);
cuda::copy_to_device(dev_q, identity.data(), identity.size());
construct_q_matrix«<block_size, threads_per_block»>(dev_q, dev_qr, dev_tau, n);
cuda::device_sync();
constexpr auto alpha = 1.f;
constexpr auto beta = 0.f;
// Compute A_k=Q_k^T * A_(k-1) * Q_k -> A_k converges to eigenvalues of A_0.
cuda::blas::gemm(blas_handle, n, n, n, alpha, dev_q, n, dev_matrix, n, beta, dev_qr, n,
,! true);
cuda::blas::gemm(blas_handle, n, n, n, alpha, dev_qr, n, dev_q, n, beta, dev_matrix, n);
// Compute L_k=Q_k * Q_(k-1)..Q_0 -> L_k converges to eigenvectors of A_0.
cuda::blas::gemm(blas_handle, n, n, n, alpha, dev_eigvecs, n, dev_q, n, beta, dev_qr, n);
cuda::copy_on_device(dev_eigvecs, dev_qr, matrix.size());
cuda::copy_on_device(dev_qr, dev_matrix, matrix.size());
}
std::vector<float> eigvecs(n * n);
cuda::copy_to_host(eigvecs, dev_eigvecs);

std::vector<float> eigvals(n * n);
cuda::copy_to_host(eigvals, dev_matrix);
cuda::free(dev_eigvecs);
cuda::free(dev_q);
cuda::free(dev_info);
cuda::free(dev_workspace);
cuda::free(dev_tau);
cuda::free(dev_qr);
cuda::free(dev_matrix);
cuda::blas::release(blas_handle);
cuda::solver::release(solver_handle);
auto trace = [](const std::vector<float>& matrix, const size_t n) {
std::vector<float> tr;
for (auto i = 0U; i < n; ++i) { tr.emplace_back(matrix[i * n + i]); }
return tr;
};
return Eigensystem(eigvecs, trace(eigvals, n));
}
int main()
{
const auto n = 4;
const std::vector<float> matrix {
5, -2, -1, 0,
-2, 5, 0, 1,
-1, 0, 5, 2,
0, 1, 2, 5,
};
std::cout « "\nInput matrix:\n";
print_matrix(matrix, n);
const auto eigensystem = compute_eigensystem(matrix, n);
std::cout « "\nComputed eigenvectors:\n";
print_matrix(eigensystem.eigenvectors, n);
std::cout « "\nComputed eigenvalues:\n";
for (auto v : eigensystem.eigenvalues) 
std::cout « v « "\n";
}