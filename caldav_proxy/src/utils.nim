import unittest
import times

let iso8601format= initTimeFormat("yyyy-MM-dd'T'hh:mm:sszzz")
let calDAVformat = initTimeFormat("yyyyMMdd'T'hhmmss'Z'")

proc parseISO8601*(datestring: string): DateTime =
    ## Parses a ISO 8601 string such as 2013-12-01T00:00:00-05:00
    return parse(datestring, iso8601format)

proc formatISO8601*(date: DateTime): string = 
    ## Formats a datetime to ISO 8601 string such as 2013-12-01T00:00:00-05:00
    return format(date, iso8601format)

proc parseCalDAVTime*(datestring: string): DateTime =
    ## Parses a CalDAV string such as 20060102T000000Z
    return parse(datestring, calDAVformat)

proc formatCalDAVTtime*(date: DateTime): string = 
    ## Formats a datetime to CalDAV such as 20060102T000000Z
    return format(date, calDAVformat)


when isMainModule:
    suite "time parsing":
        test "iso 1806":
            let input = "2013-12-01T00:00:00-05:00" 
            let parsed = parseISO8601(input).utc
            echo "parsed: " & $parsed
            let output = formatISO8601(parsed)
            echo input
            echo output
            check:
                input == output

        test "calDAV":
            let input = "20060102T000000Z" 
            let parsed = parseCalDAVTime(input).utc
            echo "parsed: " & $parsed
            let output = formatCalDAVTtime(parsed)
            check:
                input == output
