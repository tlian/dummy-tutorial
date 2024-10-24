from sqlalchemy import create_engine, ForeignKey, Column, String, Integer, CHAR, exc
from sqlalchemy.orm import sessionmaker, declarative_base

# declare SQLAlchemy DB instance
Base = declarative_base()


# Define DB table - i.e. Person object 
class Person(Base):
    # Set table name
    __tablename__ = "people"

    # Define Columns
    ssn  = Column("ssn", Integer, primary_key=True)
    firstname = Column("firstname", String)
    lastname = Column("lastname", String)
    gender = Column("gender", CHAR)
    age = Column("age", Integer)

    def __init__(self, ssn, first, last, gender, age):
        self.ssn = ssn
        self.firstname = first
        self.lastname = last
        self.gender = gender
        self.age = age

    def __repr__(self):
        return f"{self.ssn} {self.firstname} {self.lastname} {self.gender} {self.age}"

# Create DB engine and its location
engine = create_engine("sqlite:///mydb.db", echo=True)

# Create the DB on the engine
Base.metadata.create_all(bind=engine)

# Create DB session
Session = sessionmaker(bind=engine)
# Create instance of the DB Session
session = Session()

# Check if entry already exists in the DB
# q = session.query(Person.ssn).filter(Person.ssn==111)
# print(session.query(q.exists()).scalar())
# raise SystemExit()


person = Person(111, "Ngun", "Lian", "m", 38)
p1 = Person(222, "Lai", "Thang", "m", 40)
p2 = Person(333, "Susan", "Lian", "f", 36)

for x in person, p1, p2:
    try:
        session.add(x)
        session.commit()
    except exc.IntegrityError:
        session.rollback()
        print(f'[WARNING]: "{x.firstname} {x.lastname}" already exist')
    except:
        print("There was another error!")
        raise
    else:
        print("Item(s) were added successfully!")