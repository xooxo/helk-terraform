output "elasticsearch_url" {
  value = "http://${docker_container.helk_elasticsearch.name}:9200"
}

output "kibana_url" {
  value = "http://${docker_container.helk_kibana.name}:5601"
}

output "logstash_port_5044" {
  value = "${docker_container.helk_logstash.name}:5044"
}

output "logstash_port_5045" {
  value = "${docker_container.helk_logstash.name}:5045"
}
