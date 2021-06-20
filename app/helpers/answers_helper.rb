module AnswersHelper

  def format_answer_body(answer)
    body = answer.body.dup
    answer.answer_corrections.accepted.each do |correction|
      body.gsub!(correction.accepted_body, content_tag(:mark, correction.accepted_body))
    end
    body
  end

end
