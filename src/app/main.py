from flask import Flask, jsonify, request

app = Flask(__name__)

# Sample data for demonstration purposes
transactions = []
users = []

@app.route('/api/transactions', methods=['POST'])
def create_transaction():
    data = request.json
    transaction = {
        'id': len(transactions) + 1,
        'amount': data['amount'],
        'currency': data['currency'],
        'user_id': data['user_id']
    }
    transactions.append(transaction)
    return jsonify(transaction), 201

@app.route('/api/transactions', methods=['GET'])
def get_transactions():
    return jsonify(transactions), 200

@app.route('/api/users', methods=['POST'])
def create_user():
    data = request.json
    user = {
        'id': len(users) + 1,
        'name': data['name'],
        'email': data['email']
    }
    users.append(user)
    return jsonify(user), 201

@app.route('/api/users', methods=['GET'])
def get_users():
    return jsonify(users), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)