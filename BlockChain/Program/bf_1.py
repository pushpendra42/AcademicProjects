import sys
import binascii

mcf=[]

def ComputeBF(k,s):
    remainder=0
    selction=0
    direct=0
    base=0
    len2=0
    
    if k==1:
        mcf_k1=s+1
        return mcf_k1
    else:
        remainder=s % 3
        selction = int(s/3)
        direct=selction % 2
        base=int(selction/2)*3
        len2=pow(2, k-1)
        
        if direct==0:
            return ComputeBF(k-1,base+((remainder+1)%3))*pow(2,len2)+ComputeBF(k-1,base+((remainder+2)%3))
        else:
            return pow(2,len2) * ComputeBF(k-1,base+((remainder+2)%3))+ ComputeBF(k-1,base+((remainder+1)%3))
                   

if __name__ == '__main__':
	
	k=int(sys.argv[1])
	s=3*pow(2,k-1)
	bfCounter=0
	
	while bfCounter<s:
		cbf=ComputeBF(k,bfCounter)
		print(bfCounter," = ",hex(cbf).split('x')[-1]," ---- ",binascii.unhexlify(hex(cbf).split('x')[-1]))
		bfCounter=bfCounter+1

