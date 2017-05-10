/* @flow */

export type Quiz = {
  id: string,
  title: string,
  html_url: string,
  description: string,
  due_at: ?string,
  lock_at: ?string,
  points_possible: ?number,
  question_count: number,
  published: boolean,
  quiz_type: 'practice_quiz' | 'assignment' | 'graded_survey' | 'survey',
  allowed_attempts: number,
  hide_results: null | 'always' | 'until_after_last_attempt',
  time_limit: ?number,
  shuffle_answers: boolean,
  show_correct_answers: boolean,
  show_correct_answers_last_attempt: boolean,
  show_correct_answers_at: ?string,
  hide_correct_answers_at: ?string,
  one_question_at_a_time: boolean,
  scoring_policy: 'keep_average' | 'keep_latest' | 'keep_highest',
}
