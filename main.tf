terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}


resource "docker_network" "helk_network" {
  name = "helk_network"
}

resource "docker_volume" "helk_elasticsearch_data" {
  name = "helk_elasticsearch_data"
}

resource "docker_container" "helk_elasticsearch" {
  image = var.elasticsearch_image
  name  = "helk-elasticsearch"

  ports {
    internal = 9200
    external = 9200
  }

  env = [
    "discovery.type=single-node",
    "ES_JAVA_OPTS=-Xms2g -Xmx2g"
  ]

  volumes {
    container_path = "/usr/share/elasticsearch/data"
    volume_name    = docker_volume.helk_elasticsearch_data.name
  }

  networks_advanced {
    name = docker_network.helk_network.name
  }
}

resource "docker_container" "helk_kibana" {
  image = var.kibana_image
  name  = "helk-kibana"

  ports {
    internal = 5601
    external = 5601
  }

  env = [
    "ELASTICSEARCH_URL=http://helk-elasticsearch:9200"
  ]

  depends_on = [docker_container.helk_elasticsearch]

  networks_advanced {
    name = docker_network.helk_network.name
  }
}

resource "docker_container" "helk_logstash" {
  image = var.logstash_image
  name  = "helk-logstash"

  ports {
    internal = 5044
    external = 5044
  }

  ports {
    internal = 5045
    external = 5045
  }

  volumes {
    host_path      = abspath("${path.module}/logstash/pipeline")
    container_path = "/usr/share/logstash/pipeline"
  }

  depends_on = [docker_container.helk_elasticsearch]

  networks_advanced {
    name = docker_network.helk_network.name
  }
}
