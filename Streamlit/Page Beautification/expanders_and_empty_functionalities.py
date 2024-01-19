import time
import numpy as np 
import pandas as pd 
import streamlit as st 

# Page Configuration
st.set_page_config(page_title='BalleBalle ShavaShava',page_icon='🤗',layout='wide')

cases = []
for _ in range(100):
    cases.append(np.random.randint(1,7))

data = []
for i in range(1,7):
    data.append(cases.count(i))

st.header('Frequency of getting a Face')

st.bar_chart({'data':data})

with st.expander('See Explanation'):
    st.write('''
    The chart shows some numbers I got from rolling a dice 100 times and
    its basically about how many times each face appears
    ''')
    st.image("https://static.streamlit.io/examples/dice.jpg")

with st.empty():
    st.write('You need to wait for 10 seconds')
    for seconds in range(11):
        st.write('⏳' + str(seconds)+' seconds completed')
        time.sleep(1)

    st.write('10 seconds completed')

# Spinner
with st.spinner('Wait for it'):
    time.sleep(5)
    st.write('Thanks for being patient')

# Progress Bar
with st.empty():
    for percent_completed in range(100):
        time.sleep(.1)
        st.progress(percent_completed+1,text='Processing')
    st.success('Congratulations!')


st.balloons()
st.snow()

