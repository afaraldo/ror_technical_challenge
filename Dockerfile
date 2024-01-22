# Utiliza la imagen base de Ubuntu 18.04
FROM ubuntu:18.04

# Configurar la zona horaria y evitar preguntas de frontend durante la construcción del Docker
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Santiago

# Instalar dependencias necesarias para RVM y Ruby
RUN apt-get update && \
    apt-get install -y curl gpg software-properties-common build-essential  ruby-dev libssl-dev cmake autoconf bison libssl-dev nodejs shared-mime-info \
                       libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev libpq-dev imagemagick

# Importar la llave GPG de RVM
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -

# Instalar RVM
RUN \curl -sSL https://get.rvm.io | bash -s stable

# Inicializar RVM cuando se inicie el shell
RUN echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc

# Instalar y usar Ruby
RUN /bin/bash -l -c "rvm install 1.9.3 && rvm use 1.9.3 --default"

# Instalar Bundler
RUN /bin/bash -l -c "gem install bundler -v '1.17'"

# Establece el directorio de trabajo de la aplicación
WORKDIR /myapp

# Copia el Gemfile y el Gemfile.lock al contenedor
COPY Gemfile .
COPY Gemfile.lock .

# Instalar gemas usando Bundler
RUN /bin/bash -l -c "bundle install --jobs 20 --retry 5"
RUN /bin/bash -l -c "gem install foreman"

# Copiar el resto del código de la aplicación
COPY . .

# Copia el script de entrada a la ubicación deseada en el contenedor
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Define el comando de inicio de la aplicación utilizando el script de entrada
ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]

# Expone el puerto 3000 para acceder a la aplicación
EXPOSE 3000
