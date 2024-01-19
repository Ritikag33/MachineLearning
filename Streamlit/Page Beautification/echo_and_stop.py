import time
import streamlit as st 

st.write('This is code inside write statement')
st.write("st.write('This is code inside write statement')")

st.code("st.write('This is code inside write statement')")

def get_username():
    return 'Ritika'

# Using echo
with st.echo():
    def get_punc():
        return '!!!'

    greeting = 'Hi there,'
    name = get_username()
    punc = get_punc()
    st.write(greeting,name,punc)


first_name = st.text_input("First name: ")
if not first_name:
    st.warning('Please enter your first name.')
    st.stop()

last_name = st.text_input("Last name: ")
if not last_name:
    st.warning('Please enter your last name.')
    st.stop()
    
st.success('Thank you for writing your name')