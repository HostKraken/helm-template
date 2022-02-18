{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "hostkraken.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hostkraken.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "hostkraken.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "hostkraken.labels" -}}
helm.sh/chart: {{ include "hostkraken.chart" . }}
{{ include "hostkraken.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
{{- define "hostkraken.labels_mysql" -}}
helm.sh/chart: {{ include "hostkraken.chart" . }}
{{ include "hostkraken.selectorLabels_mysql" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "hostkraken.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hostkraken.domainDashed" . }}
app.kubernetes.io/instance: {{ include "hostkraken.domainDashed" . }}
{{- end -}}
{{- define "hostkraken.selectorLabels_mysql" -}}
app.kubernetes.io/name: {{ include "hostkraken.domainDashed" . }}-mysql
app.kubernetes.io/instance: {{ include "hostkraken.domainDashed" . }}-mysql
{{- end -}}

{{- define "hostkraken.domainDashed" -}}
  {{ .Values.domain | replace "." "-" }}
{{- end -}}

{{- define "hostkraken.Plugins" -}}
  {{ .Values.plugins | splitList "," }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "hostkraken.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "hostkraken.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

