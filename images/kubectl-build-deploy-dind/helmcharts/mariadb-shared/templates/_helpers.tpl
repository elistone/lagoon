{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "mariadb-shared.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "mariadb-shared.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mariadb-shared.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create full hostname for autogenerated hosts
*/}}
{{- define "mariadb-shared.autogeneratedHost" -}}
{{- printf "%s-%s" .Release.Name .Values.routesAutogenerateSuffix | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "mariadb-shared.labels" -}}
helm.sh/chart: {{ include "mariadb-shared.chart" . }}
{{ include "mariadb-shared.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "mariadb-shared.lagoonLabels" . }}

{{- end -}}

{{/*
Selector labels
*/}}
{{- define "mariadb-shared.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mariadb-shared.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Lagoon Labels
*/}}
{{- define "mariadb-shared.lagoonLabels" -}}
lagoon/service: {{ .Release.Name }}
lagoon/service-type: {{ .Chart.Name }}
lagoon/project: {{ .Values.project }}
lagoon/environment: {{ .Values.environment }}
lagoon/environmentType: {{ .Values.environmentType }}
lagoon/buildType: {{ .Values.buildType }}
{{- end -}}

{{/*
Annotations
*/}}
{{- define "mariadb-shared.annotations" -}}
lagoon/version: {{ .Values.lagoonVersion | quote }}
{{- if .Values.branch }}
lagoon/branch: {{ .Values.branch | quote }}
{{- end }}
{{- if .Values.prNumber }}
lagoon/prNumber: {{ .Values.prNumber | quote }}
lagoon/prHeadBranch: {{ .Values.prHeadBranch | quote }}
lagoon/prBaseBranch: {{ .Values.prBaseBranch | quote }}
{{- end }}
{{- end -}}