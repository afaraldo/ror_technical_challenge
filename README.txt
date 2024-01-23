# Para levantar el proyecto

docker compose up

Visitar http:localhost:3000

## Pruebas Manuales

Visitar Docs Api Swagger: http://localhost:8080/

* Login
curl -X POST 'http://localhost:3000/api/v1/users/login' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{ "email":"afaraldo.dev@gmail.com", "password": "test1234"}'

Logros alcanzados
1. Se alcanzó todos los requisitos funcionales.
2. Documentación Swagger
3. Comentarios en el codigo, Uso de concerns.
4. Relaciones usadas belongs_to, has_many, has_and_belongs_to_many
5. Integración con Sendgrid para el envió de email.
6. Envió de emails se encolá en sidekiq.
7. Cron Tasks realizado.
8. Authenticación con jwt.
9. Montaje en docker-compose swagger, redis, rails y postgres.
10. 10. Deseables pero no requeridos:
    b. Lógica de modelos implementada que permita tener registro de qué
    usuario Administrado hizo algún cambio. (Con Audit gem)
    c. Diagrama de entidad relación de los modelos. (Con erd gem)
    d. Documentación de APIs con openapi/swagger. (Con grape-swagger)



