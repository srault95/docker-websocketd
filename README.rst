Docker example for Websocketd behind Nginx Proxy
================================================


Docker Build
------------

::

    git clone https://github.com/srault95/docker-websocketd.git
    
    cd docker-websocketd
    
    docker build -t srault95/websocketd .
    
Docker Run
----------

::

   docker run -d --name mysocket srault95/websocketd  