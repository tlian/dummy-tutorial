


from flask import Flask, request, render_template

# Create a Flask app
app = Flask(__name__)

# Define a route
@app.route('/', methods=['GET', 'POST'])
def index():
    # If the request method is POST, it means the form has been submitted.
    if request.method == 'POST':
        # Extract value from the form data defined in templates/form.html data
        name = request.form['name']
        email = request.form['email']
        phone = request.form['phone']
        address = request.form['address']
        # Return the data in HTML format so that it's more easier to read
        return f"<p>Name: {name}</p><p>Email: {email}</p><p>Phone:{phone}</p><p>Address:{address}<p>"
    return render_template('form.html')

if __name__ == '__main__':
    app.run(debug=True, port=5001)