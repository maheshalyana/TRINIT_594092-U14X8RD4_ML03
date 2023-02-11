
"""# Using model for API"""

from flask import Flask, request

# from sklearn.externals import joblib
import joblib

app = Flask(__name__)


@app.route("/predict", methods=["POST"])
def predict():
    # Get the input data from the request
    data = request.get_json(force=True)
    # data = {
    #    'N': 107,'P':	34,'K':	32,'temperature':	26.774637,'humidity':	66.413269,'ph':	6.780064,'rainfall':	177.774507,
    # }
    X = [
        [
            data["N"],
            data["P"],
            data["K"],
            data["temperature"],
            data["humidity"],
            data["ph"],
            data["rainfall"],
        ]
    ]
    print(X)
    # X.reshape(-1,1)
    print(X)
    # Load the trained model
    clf = joblib.load("content/models/RandomForest.pkl")

    # Use the model to make a prediction
    y_pred = clf.predict(X)
    print(y_pred)
    prices = {
        "rice": 100,
        "maize": 100,
        "jute": 100,
        "cotton": 100,
        "coconut": 100,
        "papaya": 100,
        "orange": 100,
        "apple": 100,
        "muskmelon": 100,
        "watermelon": 100,
        "grapes": 100,
        "mango": 100,
        "banana": 100,
        "pomegranate": 100,
        "lentil": 100,
        "blackgram": 100,
        "mungbean": 100,
        "mothbeans": 100,
        "pigeonpeas": 100,
        "kidneybeans": 100,
        "chickpea": 100,
        "coffee": 100,
    }
    # Return the prediction as a response
    print(y_pred)
    print(type(y_pred))
    return {"prediction": y_pred.tolist() + [prices[y_pred[0]]]}


if __name__ == "__main__":
    app.run(port=8082, debug=True)

