import time
import numpy as np 
import pandas as pd
import streamlit as st 

# Static
tab1,tab2,tab3 = st.tabs(['Cat','Dog','Owl'])
tab1.image("https://static.streamlit.io/examples/cat.jpg",width=200)
tab2.image("https://static.streamlit.io/examples/dog.jpg",width=200)
tab3.image("https://static.streamlit.io/examples/owl.jpg",width=200)

imgs = pd.read_csv("./images.csv")['img_link']

tabs = st.tabs(["ID"]*30)
for tab in tabs:
    img = imgs[np.random.randint(0,len(imgs))]
    tab.image(img,width=400)