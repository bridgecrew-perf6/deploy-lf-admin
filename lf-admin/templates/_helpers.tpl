{{/*
Expand the name of the chart.
*/}}
{{- define "lf-admin.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lf-admin.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "lf-admin.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lf-admin.labels" -}}
helm.sh/chart: {{ include "lf-admin.chart" . }}
{{ include "lf-admin.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{- define "lf-admin-redis.labels" -}}
helm.sh/chart: {{ include "lf-admin.chart" . }}
{{ include "lf-admin-redis.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lf-admin.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lf-admin.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "lf-admin-redis.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lf-admin.name" . }}-redis
app.kubernetes.io/instance: {{ .Release.Name }}-redis
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "lf-admin.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "lf-admin.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
