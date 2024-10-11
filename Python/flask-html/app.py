


from flask import Flask, request, render_template

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        phone = request.form['phone']
        address = request.form['address']
        return f"<p>Name: {name}</p><p>Email: {email}</p><p>Phone:{phone}</p><p>Address:{address}<p>"
    return render_template('form.html')

if __name__ == '__main__':
    app.run(debug=True, port=5001)