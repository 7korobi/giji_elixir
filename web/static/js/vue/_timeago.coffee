MINUTE = 60
HOUR = MINUTE * 60
DAY = HOUR * 24
WEEK = DAY * 7
MONTH = DAY * 30
YEAR = DAY * 365

times = [
  [      25, Infinity]
  [  MINUTE,        1]
  [    HOUR,   MINUTE]
  [     DAY,     HOUR]
  [    WEEK,      DAY]
  [   MONTH,     WEEK]
  [    YEAR,    MONTH]
  [Infinity,     YEAR]
]

locales = [
    "たった今"
    "%s 秒前"
    "%s 分前"
    "%s 時間前"
    "%s 日前"
    "%s 週間前"
    "%s ヶ月前"
    "%s 年前"
  ]

format =
  date: new Intl.DateTimeFormat 'ja-JP',
    year:  "numeric"
    month: "2-digit"
    day:   "2-digit"
    weekday: "short"
    hour:    "2-digit"

  num: new Intl.NumberFormat 'ja-JP',
    style: 'decimal'
    useGrouping: true
    minimumIntegerDigits: 1
    minimumSignificantDigits:  1
    maximumSignificantDigits: 21
    minimumFractionDigits: 0
    maximumFractionDigits: 2


module.exports =
  data: ->
    now: Date.now()

  props:
    since:
      required: true
    maxTime:
      type: Number
      default: 10 * YEAR
    lock:
      type: Boolean
      default: false

  computed:
    sinceTime: ->
      new Date(@since).getTime()
    seconds: ->
      @now / 1000 - @sinceTime / 1000
    baseTime: ->
      times[@idx][1]
    idx: ->
      for [limit, base], idx in times when @seconds < limit
        return idx
      return times.length - 1
    timeago: ->
      if @maxTime && @seconds > @maxTime
        clearInterval @interval
        @interval = null
        return format.date.format(@sinceTime) + "頃"

      locales[@idx].replace '%s', Math.round @seconds / @baseTime
    tick: ->
      if @period != @baseTime
        if @interval
          clearInterval @interval
        @interval = setInterval =>
          @now = Date.now()
          @tick
        , @period = @baseTime
      @period

  render: (m)->
    m 'time',
      attrs:
        datetime: new Date @since
    , @timeago

  mounted: ->
    return if @lock
    @tick

  beforeDestroy: ->
    return if @lock
    clearInterval @interval
    @interval = null
