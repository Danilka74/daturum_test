module AnswersHelper

  def format_answer_body(answer)
    body = answer.body.dup
    answer.answer_corrections.accepted.each do |correction|
      body.gsub!(correction.accepted_body, content_tag(:span, correction.accepted_body, id: correction.id, data: { colorize_target: 'text' } ))
    end
    body
  end

end
