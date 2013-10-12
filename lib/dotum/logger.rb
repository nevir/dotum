class Dotum::Logger
  include Dotum::Util::ANSIControl

  INDENT = '  '

  def start_rule(rule)
    @last_rule       = rule
    @last_rule_start = Time.now

    print "\n"
    print rule_line(rule)
  end

  def finish_rule(rule, status, reason)
    message = "#{rule_line(rule)} - #{status.inspect} - #{reason.inspect}"
    if @last_rule == rule
      delta = (Time.now - @last_rule_start) * 1000.0
      message += sprintf(' (%.2fms)', delta)

      print "\r"
    else
      print "\n\n"
    end

    print message
  end

  private

  def rule_line(rule)
    indent  = INDENT * rule.context.depth
    action  = rule.class.pretty
    subject = rule.pretty_subject

    action  = c_cyan(action)
    subject = colorize_subject(subject)

    "#{indent}#{action}: #{subject}"
  end

  SUBJECT_MATCHER = /^(.*?)( \(.+\))?$/
  def colorize_subject(subject)
    match = SUBJECT_MATCHER.match(subject)

    "#{c_magenta(match[1])}#{match[2]}"
  end

end
