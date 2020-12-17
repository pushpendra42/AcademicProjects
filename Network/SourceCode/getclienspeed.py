import pyspeedtest

st = pyspeedtest.SpeedTest()
st.ping()
downloadSpeed=st.download()
print downloadSpeed
uploadSpeed=st.upload()
print uploadSpeed
