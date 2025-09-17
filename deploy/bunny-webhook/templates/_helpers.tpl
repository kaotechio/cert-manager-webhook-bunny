{{/* vim: set filetype=mustache: */}}
{{/* Expand the name of the chart. */}}
{{- define "bunny-webhook.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create a default fully qualified app name. */}}
{{- define "bunny-webhook.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/* Chart name and version */}}
{{- define "bunny-webhook.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "bunny-webhook.selfSignedIssuer" -}}
{{ printf "%s-selfsign" (include "bunny-webhook.fullname" .) }}
{{- end -}}

{{- define "bunny-webhook.rootCAIssuer" -}}
{{ printf "%s-ca" (include "bunny-webhook.fullname" .) }}
{{- end -}}

{{- define "bunny-webhook.rootCACertificate" -}}
{{ printf "%s-ca" (include "bunny-webhook.fullname" .) }}
{{- end -}}

{{- define "bunny-webhook.servingCertificate" -}}
{{ printf "%s-webhook-tls" (include "bunny-webhook.fullname" .) }}
{{- end -}}

