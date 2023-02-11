from flask import Flask, request
# from sklearn.externals import joblib
import joblib

app = Flask(__name__)

@app.route('/')
def predict():
  return 'Hello world'
    

if __name__ == '__main__':
    app.run(port=8082,debug = True)
    
    # print(predict(data))
