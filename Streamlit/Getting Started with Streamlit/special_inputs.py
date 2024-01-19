import streamlit as st 

st.subheader('1.Radio Button')
gender = st.radio('Select your gender:', options=('Male', 'Female', 'Other'), index=1, help='Choose one', key='gender')
st.write("You've selected ",gender)

st.subheader('2. Select Box')
options = st.selectbox('Select your options:',options=('Data Analysis','ML','DL','AI'),help='Choose one')
st.write("You've selected ",options)

st.subheader('3. Multi-Select Box')
options = st.multiselect('Select your options:',options=('Data Analysis','ML','DL','AI'),help='Choose one',default='Data Analysis')

st.subheader('4. Button')
if st.button('Say Hello'):
    st.write('Hi')

st.subheader('5. Checkbox')
if st.checkbox('I agree to the terms and conditions.',help='You must agree to preceed'):
    st.write('Thank you for agreeing')

st.subheader('6. Color Picker')
color = st.color_picker('Select your favourite color:','#FF3A56')
st.write("You've selected",color,"color")

st.button("Submit your Response")

