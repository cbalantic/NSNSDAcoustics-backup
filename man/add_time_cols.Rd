% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers.R
\name{add_time_cols}
\alias{add_time_cols}
\title{Add R-friendly time-based columns to bioacoustics data}
\usage{
add_time_cols(
  dt,
  recording.id.col = "recordingID",
  tz.recorder,
  tz.local,
  timestep = 10
)
}
\arguments{
\item{dt}{Data.frame or data.table containing a recordingID column of format NAME_YYYYMMDD_HHMMSS.wav}

\item{recording.id.col}{Column name that contains recordingID with format 'NAME_YYYYMMDD_HHMMSS.wav'. Default = 'recordingID'.}

\item{tz.recorder}{Olsen names timezone used by the audio recorder during data collection. For example, you may have collected data using a Wildlife Acoustics SM4, and may have used UTC/GMT instead of setting a local time. Note that 'UTC' and 'GMT' are synonymous and both acceptable for this function argument. This argument accounts for the fact that recordings may have been taken in UTC. The tz.local argument then allows us to convert the times to local times that will make sense for analysis.}

\item{tz.local}{Olsen names timezone for local time at the monitoring location (e.g., 'America/Anchorage').}

\item{timestep}{If adding time columns with the intention of pairing automated detection data with a 'time' column with acoustic indices (AI) data, please add the time increment used to generate the AI data (e.g., "10" for 10 minutes).}
}
\value{
A data.table with the same columns as the input, but now including the following additional columns:
\itemize{
\item{\strong{dateTimeRecorder}: POSIXct-formatted date-time object used by the audio recorder (typically will be the same as UTC or local time, depending on recording configuration parameters used in the field). }
\item{\strong{dateTimeUTC}: POSIXct-formatted date-time object in UTC time. }
\item{\strong{dateTimeLocal}: POSIXct-formatted date-time object in local time. }
}

If the input data.frame or data.table contains a 'time' column as from an AMMonitor scores table, then the timestep argument is utilized in the function and the following two additional columns are returned:

#' \itemize{
\item{\strong{detectionTime}: POSIXct-formatted date-time object giving the exact detection time, to the second, of the detected event. }
\item{\strong{detectionTimeMinute}: POSIXct-formatted date-time object giving the detection time rounded down to the nearest minute.}
}
}
\description{
Convenience function to parse recordingIDs into useful columns to allow expedient summaries by date, local time, hour, etc. Input table must have a parseable recordingID column.
}
\details{
This function was developed by the National Park Service Natural Sounds and Night Skies Division to support bioacoustics projects such as those related to acoustic indices and automated detection of focal species.
}
\examples{
\dontrun{

# Ensure your data has an appropriate recordingID column and time columns
dat <- exampleHeatmapData
dat[ , recordingID := basename(filepath)]
dat <- add_time_cols(
 dt = dat,
 tz.recorder = 'America/Los_angeles',
 tz.local = 'America/Los_angeles'
)


}
}
