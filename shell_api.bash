#!/bin/bash 
#Author: Rodrigo Pacheco
#version: v1.0
#This script change the apiversion after cluster version migration.

for PROJ in `oc projects -q` ; do HPA=`oc get HPA -A -o custom-columns=HPANAME:.metadata.name` ;  

oc patch hpa/$HPA -p '{"spec": { "scaleTargetRef": { "apiVersion": "apps.openshift.io/v1"}}}' -n $PROJ ; 

oc get hpa $HPA -n $PROJ -o jsonpath='{"NAME: "}{.metadata.name}{"\n"}{"NEWNAME APIVERSION: "}{.spec.scaleTargetRef.apiVersion}{"\n"}' ;

done 
