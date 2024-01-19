import streamlit as st 
st.title('Hello Fellow!')
# Displaying text of different format using streamlit

# Title
st.title('Title - Yoo')

# Header
st.header('Header -Yoo')

# Subheader
st.subheader('Subheader -Yoo')

# Text
st.text('Text -Yoo')


# Markdown
st.markdown('This is a list of h tags using markdown')  #p
st.markdown('# Hola')                  # h1
st.markdown('## Hola')                 # h2
st.markdown('### Hola')                # h3
st.markdown('#### Hola')               # h4
st.markdown('##### Hola')              # h5
st.markdown('###### Hola')             # h6

st.markdown('H**O**LA')
st.markdown('Today is **Sunday**')     # Bold
st.markdown('Today is __Sunday__')     # Bold

st.markdown('Today is *Sunday*')       # Italic
st.markdown('Today is _Sunday_')       # Italic

st.markdown('Today is ***Sunday***')       # Bold + Italic
st.markdown('Today is ___Sunday___')       # Bold + Italic

st.markdown('1. First Point')
st.markdown('2. Second Point')
st.markdown('3. Third Point')

st.markdown('''1. First Point
               2. Second Point
               3. Third Point''')

st.markdown('- First Point')
st.markdown('- Second Point')
st.markdown('- Third Point')

st.write('Text is here')
st.write('range(1,10)')
st.write(range(1,10))
st.text(range(1,10))