# frozen_string_literal: true

require 'time'

class TodoMarkdown
  class << self
    def clean_markdown(text)
      text = text.gsub(/\e\[0m\n/, "\n")
      text = text.gsub(/\e\[0[^ ]*/, '')
      text = text.gsub(/\[\[0[^ ]*/, '')
      text = text.gsub(/0;[^ ]*/, '')

      # text = text.gsub(/ +/, ' ')
      text = text.gsub(/ ?\e[^ ]*/, '')
      text = text.gsub('\n', "\n")
      text = text.gsub('\t', "\t")
      text = text.gsub('      ', '     ')
      text = text.gsub('*****', '\newpage')
      text = text.gsub('👀', ':eyes:')
      text = text.gsub('⛔️', ':no-entry:')
      text = text.gsub('🔥', ':fire:')
      text = text.gsub('🛑', ':stop:')
      text = text.gsub('🍒', ':cherries:')
      text = text.gsub('🔧', ':wrench:')
      text = text.gsub('{noformat}', "```\n")

      text
    end

    def clean_to_slack(text)
      text = text.gsub(/^\|[-\s]+[-|]*\s*\n/, '')
      text = text.gsub(/^% Standup:/, "#{Time.now.strftime('%Y-%m-%d')} Standup:")
      text = text.gsub(/^% /, '')
      text = text.gsub(/\* *\| */, '* ')
      text = text.gsub(/^\|/, '')
      text = text.gsub(/^\\newpage *\n/, '')
      text = text.gsub(/^## +(.*)\n\n/, '## ----  \1  ------------------------------' + "\n")
      text = text.gsub('      ', '     ')
      text = text.gsub(/^\*/, '    - *')
      text = text.gsub('               | ', "\n  - ")

      text
    end
  end
end
