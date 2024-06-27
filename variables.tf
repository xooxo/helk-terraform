variable "elasticsearch_image" {
  description = "Elasticsearch Docker image"
  default     = "docker.elastic.co/elasticsearch/elasticsearch:7.6.2"
}

variable "kibana_image" {
  description = "Kibana Docker image"
  default     = "docker.elastic.co/kibana/kibana:7.6.2"
}

variable "logstash_image" {
  description = "Logstash Docker image"
  default     = "docker.elastic.co/logstash/logstash:7.6.2"
}
