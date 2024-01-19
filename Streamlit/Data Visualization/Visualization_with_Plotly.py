import numpy as np 
import pandas as pd 
import streamlit as st 
import matplotlib.pyplot as plt 

import plotly.express as px 
import plotly.figure_factory as ff 

st.title('Visualization with PLotly')
df = pd.read_csv("tips.csv")
st.dataframe(df.head())

st.text('1. Pie Chart')
fig = px.pie(df,values = 'total_bill',names = 'day')
st.plotly_chart(fig)


st.text('1. Pie Chart with Hole')
fig = px.pie(df,values = 'total_bill',names = 'day',opacity=0.7, hole=0.5,
            color_discrete_sequence=px.colors.sequential.RdBu)
st.plotly_chart(fig)

st.text('Multiple Distribution Plots')
x1 = np.random.randn(200) + 2
x2 = np.random.randn(200)
x3 = np.random.randn(200) - 2

hist_data = [x1,x2,x3]
group_lbls = ['G1','G2','G3']

fig = ff.create_distplot(hist_data,group_lbls,bin_size=[0.1,0.1,0.1])
st.plotly_chart(fig,use_container_width=True)

fig = ff.create_distplot(hist_data,group_lbls,bin_size=[0.1,0.5,0.25])
st.plotly_chart(fig,use_container_width=True)