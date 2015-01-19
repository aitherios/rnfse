module Rnfse

  class CallChain
    def self.caller_method(depth = 1)
      parse_caller(caller(depth + 1).first).last
    end

    private

    # Stolen from ActionMailer with a tweek,
    # where this was used but was not made reusable
    def self.parse_caller(at)
      if /^(.+?):(\d+)(?::in `((block in )?(.*))')?/ =~ at
        file   = Regexp.last_match[1]
        line   = Regexp.last_match[2].to_i
        method = Regexp.last_match[5]
        [file, line, method]
      end
    end
  end

end
