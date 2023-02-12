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
        "rice": ["2200", "2500", "2400"],
        "maize": ["1700", "1800", "1800"],
        "jute": ["3600", "3900", "3900"],
        "cotton": ["4500", "4600", "4550"],
        "coconut": ["3200", "3400", "3300"],
        "papaya": ["1200", "1500", "1500"],
        "orange": ["1710", "1790", "1750"],
        "apple": ["6200", "6290", "6250"],
        "muskmelon": ["1200", "1600", "1400"],
        "watermelon": ["1200", "1600", "1400"],
        "grapes": ["1500", "6000", "3000"],
        "mango": ["3300", "3500", "3400"],
        "banana": ["3800", "4100", "4000"],
        "pomegranate": ["250", "7000", "4000"],
        "lentil": ["4375" "4445" "4410"],
        "blackgram": ["5050", "5100", "5075"],
        "mungbean": ["8000", "10000", "9000"],
        "mothbeans": ["2200" "2300" "2250"],
        "pigeonpeas": ["1100", "1500", "1325"],
        "kidneybeans": ["1000", "1700", "1450"],
        "chickpea": ["1000", "1400", "1200"],
        "coffee": ["400", "500", "595"],
    }
    # Return the prediction as a response
    print(y_pred)
    print(type(y_pred))

    return {"prediction": y_pred.tolist() + prices[y_pred[0]]}


if __name__ == "__main__":
    app.run(port=8082, debug=True)
