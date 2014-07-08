define [
], () ->
  local = true # Use this to switch between local and staging databases

  config =
    baseUrl: if local then ""
