import pandas as pd
import streamlit as st 

df = pd.read_csv('./images.csv')
st.subheader('1.Displaying the whole dataframe')
st.dataframe(df)

st.subheader('2.Displaying the head of dataframe')
st.dataframe(df.head())

st.subheader('3.Displaying the tail of dataframe')
st.dataframe(df.tail())

st.subheader('4.Displaying in a Table(First 5 rows)')
st.table(df.head(5))

st.subheader('5. Displaying JSON')
js = [{'pid':1,"name":'5 Star'},
      {'pid':2,"name":'Milky Bar'},
      {'pid':3,"name":'Dark Chocolate'},
      {'pid':4,"name":'Snickers'},
      {'pid':5,"name":'Dairy Milk Silk'}]

st.json(js)

st.subheader('6. Displaying Data Description')
st.table(df.describe())