#!/bin/bash

source $PWD/config.sh 

aws emr create-cluster --profile ${PROFILE} --region ${REGION}s --name ${CLUSTER_NAME} --ami-version ${AMI_VSN} --instance-type ${INSTANCE_TYPE} --instance-count ${INSTANCE_COUNT} \
  --log-uri ${LOG_URL} \
  --enable-debugging \
  --ec2-attributes KeyName=${KEYNAME} --applications Name=Hive Name=GANGLIA \
  --bootstrap-actions Name=Install_Spark,Path=s3://support.elasticmapreduce/spark/install-spark  Name=Install_iPython_NB,Path=s3://elasticmapreduce.bootstrapactions/ipython-notebook/install-ipython-notebook \
  --steps Name=SparkHistoryServer,Jar=s3://elasticmapreduce/libs/script-runner/script-runner.jar,Args=s3://support.elasticmapreduce/spark/start-history-server Name=SparkConfigure,Jar=s3://elasticmapreduce/libs/script-runner/script-runner.jar,Args=[s3://support.elasticmapreduce/spark/configure-spark.bash,spark.default.parallelism=100,spark.locality.wait.rack=0]
