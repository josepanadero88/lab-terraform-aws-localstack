def handler(event, context):
    print("¡Hola desde la Lambda en LocalStack!")
    return {
        "statusCode": 200,
        "body": "Función ejecutada correctamente!!"
    }
