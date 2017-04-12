#!/bin/sh
registration_name="192.168.29.158:5000/elasticsearch"
container_id=0
while [ "$container_id" = "0" ]
 do
    container_id=$(docker ps|grep "$registration_name"|awk '{print $1}')
    [ "$container_id" = "" ] && container_id=0
    sleep 1s
 done
echo $container_id

curl -XDELETE 'http://127.0.0.1:9201/user'
curl -XPUT 'http://127.0.0.1:9201/user'
curl -XPOST 'http://127.0.0.1:9201/user/default/_mapping' -d'
            {
                "default": {
                    "_all": {
                        "analyzer": "ik_max_word",
                        "search_analyzer": "ik_max_word",
                        "term_vector": "no",
                        "store": "false"
                    },
                    "properties": {
                        "real_name": {
                            "type": "string",
                            "analyzer": "ik_max_word",
                            "search_analyzer": "ik_max_word"
                        },
                        "last_login_at": {
                            "type": "string",
                            "index": "not_analyzed"
                        },
                        "register_at": {
                            "type": "string",
                            "index": "not_analyzed"
                        },
                        "email": {
                            "type": "string",
                            "index": "not_analyzed"
                        },
                        "mobile": {
                            "type": "string",
                            "index": "not_analyzed"
                        },
                        "status": {
                            "type": "short",
                            "index": "not_analyzed"
                        },
                        "company_list": {
                            "type": "string",
                            "analyzer": "ik_max_word",
                            "search_analyzer": "ik_max_word"
                        },
                        "job_list": {
                            "type": "string",
                            "analyzer": "ik_max_word",
                            "search_analyzer": "ik_max_word"
                        },
                        "on_duty_company": {
                            "type": "string",
                            "analyzer": "ik_max_word",
                            "search_analyzer": "ik_max_word"
                        },
                        "on_duty_job": {
                            "type": "string",
                            "analyzer": "ik_max_word",
                            "search_analyzer": "ik_max_word"
                        },
                        "school_list": {
                            "type": "string",
                            "analyzer": "ik_max_word",
                            "search_analyzer": "ik_max_word"
                        },
                        "higher_education_list": {
                            "properties": {
                                "major": {
                                    "type": "string",
                                    "analyzer": "ik_max_word",
                                    "search_analyzer": "ik_max_word"
                                },
                                "school": {
                                    "type": "string",
                                    "analyzer": "ik_max_word",
                                    "search_analyzer": "ik_max_word"
                                }
                            }
                        },
                        "province_code": {
                            "type": "string",
                            "index": "not_analyzed"
                        },
                        "city_code": {
                            "type": "string",
                            "index": "not_analyzed"
                        },
                        "credential_type": {
                            "type": "short",
                            "index": "not_analyzed"
                        },
                        "credential_no": {
                            "type": "string",
                            "index": "not_analyzed"
                        },
                        "position_list": {
                            "type": "string",
                            "analyzer": "ik_max_word",
                            "search_analyzer": "ik_max_word"
                        },
                        "position_id_list": {
                            "type": "string",
                            "analyzer": "standard",
                            "search_analyzer": "standard"
                        },
                        "position_skill_id_list": {
                            "type": "string",
                            "analyzer": "standard",
                            "search_analyzer": "standard"
                        },
                        "start_work_date":{
                            "type": "date"
                        }
                    }
                }
            }'
