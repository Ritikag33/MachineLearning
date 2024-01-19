import time
import numpy as np 
import streamlit as st 
import pandas as pd 

# Generating different column using streamlit
col1,col2,col3 = st.columns(3)

# Static
with col1:
   st.header("A cat")
   st.image("https://static.streamlit.io/examples/cat.jpg",width=200)

with col2:
   st.header("A dog")
   st.image("https://static.streamlit.io/examples/dog.jpg",width=200)

with col3:
   st.header("An owl")
   st.image("https://static.streamlit.io/examples/owl.jpg",width=200)


# Dynamic
csv_file_path = './images.csv'
df = pd.read_csv(csv_file_path)

if 'img_link' not in df.columns:
    st.error('No img_link column found')
else:
    n = st.number_input('How many columns do you want?',1,10)

    cols = st.columns(n)
    for index, col in enumerate(cols):
        # Check if current index is less than the number of rows in dataframe
        if index < len(df):
            with col:
                image_link = df['img_link'].iloc[index]
                st.image(image_link, caption=f"Image {index + 1}", use_column_width=True)
        else:
            st.text("No image available")