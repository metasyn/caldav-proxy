import asyncdispatch, os, strutils, htmlgen, strformat, json
import jester

let port = 8000.Port

proc proxyRequest(earliest: string, latest: string): string =
  ## Proxies a feed request from fullcalendar into a CalDAV REPORT request.
  ## Then translates the results back into an array of json that fullcalendar can consume.
  
  return "hi"
  

router caldav:
  get "/":
    resp h1("Hello world")

  get "/events":
    let earliestKey = "start"
    let latestKey = "end"
    var status = Http200
    var body = ""

    let params = request.params

    # Handle missing earliest key
    if not params.hasKey(earliestKey):
      status = Http400
      let bodyJson = %* {"status": $status, "error": fmt"{earliestKey} is a required query parameter"}
      body = $bodyJson

    # Handle missing latest key
    if not params.hasKey(latestKey):
      status = Http400
      let bodyJson = %* {"status": $status, "error": fmt"{latestKey} is a required query parameter"}
      body = $bodyJson

    body = proxyRequest(params[earliestKey], params[latestKey])

    resp(status, $body, "application/json")

proc main() =
  let settings = newSettings(port=port)
  var jester = initJester(caldav, settings=settings)
  jester.serve()

when isMainModule:
  echo "Starting server..."
  main()
