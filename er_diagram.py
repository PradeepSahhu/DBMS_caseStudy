from sqlalchemy import create_engine
import sqlacodegen

# Connect to the database
engine = create_engine('mysql://root:Pradeep@2002@127.0.0.1/case_study')

# Generate SQLAlchemy models
models = sqlacodegen.codegen(engine)

# Print the models (ER diagram)
print(models)
