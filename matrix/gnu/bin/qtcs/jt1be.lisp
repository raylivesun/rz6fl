;; name project jt1be
;; name program jt1
;; name extension lisp
;; name describer "A simple Lisp interpreter"
;; name data 1
;; name unit 1
;; name function 1 "eval"
;; name function 2 "read"
;; name function 3 "write"
;; name function 4 "display"
;; name function 5 "newline"
;; name function 6 "car"
;; name function 7 "cdr"
;; name function 8 "cons"
;; name function 9 "list"
;; name function 10 "null?"
;; name function 11 "atom?"
;; name function 12 "eq?"
;; name function 13 "equal?"
;; name function 14 "cons?"
;; name function 15 "length"
;; name function 16 "reverse"
;; name function 17 "append"
;; name function 18 "map"
;; name function 19 "filter"
;; name function 20 "reduce"
;; name function 21 "lambda"
;; name function 22 "apply"
;; name function 23 "define"
;; name function 24 "set!"
;; name function 25 "if"
;; name function 26 "cond"
;; name function 27 "let"
;; name function 28 "let*"
;; name function 29 "letrec"
;; name function 30 "delay"
;; name function 31 "force"
;; name function 32 "quote"
;; name function 33 "begin"
;; name function 34 "and"
;; name function 35 "or"
;; name function 36 "not"
;; name function 37 "case"
;; name function 38 "let*-values"
;; name function 39 "let*-syntax"
;; name function 40 "case-lambda"
;; name function 41 "case-lambda-values"
;; name function 42 "case-lambda-syntax"
;; name function 43 "case-let"
;; name function 44 "case-let*-values"
;; name function 45 "case-let*-syntax"
;; name function 46 "case-lambda-let"
;; name function 47 "case-lambda-let*-values"
;; name function 48 "case-lambda-let*-syntax"
;; name function 49 "case-letrec"
;; name function 50 "case-letrec*-values"
;; name function 51 "case-letrec*-syntax"
;; name function 52 "case-lambda-letrec"
;; name function 53 "case-lambda-letrec*-values"
;; name function 54 "case-lambda-letrec*-syntax"
;; name function 55 "case-values"
;; name function 56 "case-syntax"
;; name function 57 "let*-values"
;; name function 58 "let*-syntax"
;; name function 59 "letrec-values"
;; name function 60 "letrec-syntax"
;; name function 61 "let*-values*"
;; name function 62 "let*-syntax*"
;; name function 63 "letrec-values*"
;; name function 64 "letrec-syntax*"
;; name function 65 "let*-values-ex"
;; name function 66 "let*-syntax-ex"
;; name function 67 "letrec-values-ex"
;; name function 68 "letrec-syntax-ex"
;; name function 69 "let*-values-ex*"
;; name function 70 "let*-syntax-ex*"
;; name function 71 "letrec-values-ex*"
;; name function 72 "letrec-syntax-ex*"
;; name function 73 "let*-values-in"
;; name function 74 "let*-syntax-in"
;; name function 75 "letrec-values-in"
;; name function 76 "letrec-syntax-in"
;; name function 77 "let*-values-in*"
;; name function 78 "let*-syntax-in*"
;; name function 79 "letrec-values-in*"
;; name function 80 "letrec-syntax-in*"
;; name function 81 "let*-values-out"
;; name function 82 "let*-syntax-out"
;; name function 83 "letrec-values-out"
;; name function 84 "letrec-syntax-out"
;; name function 85 "let*-values-out*"
;; name function 86 "let*-syntax-out*"
;; name function 87 "letrec-values-out*"




;; Read a character from the input stream.
(defun read-char (input-stream)
  (char->integer (read-char-no-hang input-stream)))

;; Read a character from the input stream without blocking.
(defun eval (expr env)
  (cond ((symbol? expr) (get expr env))
        ((number? expr) expr)
        ((string? expr) expr)))

;; Read an expression from the input stream.

(defun read (input-stream)
  (let ((char (read-char input-stream)))
    (cond ((char #\()) nil))))

    (defun read-list (input-stream)
      (let ((expr (read input-stream)))
        (cond ((null? expr) nil)
              ((eq? expr #\)) (read input-stream))
              (t (cons (eval expr env) (read-list input-stream))))))

    (cond ((eq? char #\()) nil)
      ((eq? char #\(') (read-list input-stream))
          ((char-number? char) (number->string char))
          (t (string char)))))  



;; Write a character to the output stream.
(defun write-char (char output-stream)
  (write-string (char->string char) output-stream))

;; Evaluate an expression and print its result.
(defun write (expr env)
  (write-char #\(' output-stream)
  (write expr env)
  (write-char #\) output-stream)
  (newline-output-stream))

;; Evaluate an expression and return its result.
(defun eval (expr env)
  (cond ((symbol? expr) (get expr env))
        ((number? expr) expr)
        ((string? expr) expr)
        ((list? expr) (let ((op (car expr)))
                        (cond ((eq? op 'quote) (cdr expr))
                              ((eq? op 'if) (let ((cond-expr (car (cdr expr))))
                                                   (if (eval cond-expr env)
                                                       (eval (car (cddr (cddr expr))) env)
                                                       (eval (car (cddr expr)) env))))

                              ((eq? op 'lambda) (lambda (parms . body) (list 'fn parms body)))
                              ((eq? op 'define) (set! (car (cdr expr)) (eval (cddr expr) env)))
                              ((eq? op 'set!) (set! (car (cddr expr)) (eval (cadr expr) env)))
                              ((eq? op 'begin) (eval (car expr) env) (eval (cddr expr) env))
                              ((eq? op 'and) (let ((result t))
                                            (map (lambda (x) (set! result (and result (eval x env)))) (cdr expr))
                                            result))
                              ((eq? op 'or) (let ((result nil))
                                            (map (lambda (x) (set! result (or result (eval x env)))) (cdr expr))
                                            result))
                                            (eq? op 'not) (not (eval (car (cdr expr)) env))))
                                            (t (eval (car expr) env) (apply (car (cdr expr)) (map eval (cdr (cdr expr))))))))
                                            (write expr env)
                                            (newline-output-stream))))
                                            (write-char #\))
                                            (newline-output-stream)))
                                            (read-char input-stream)
                                            (let ((expr (read-list input-stream)))
                                              (write expr env)
                                              (newline-output-stream)
                                              (eval expr env))))
                                              (t (write-char #\')
                                              (write expr env)
                                              (write-char #\)
                                              (newline-output-stream))))
                                              (read-char input-stream)
                                              (let ((expr (read input-stream)))
                                                (write expr env)
                                                (newline-output-stream)
                                                (eval expr env))))

;; Evaluate the given expression and print its result.
(defun repl ()
  (let ((input-stream (open-input-string ""))
  (output-stream (open-output-string)))
  (write-string "(jt1> " output-stream)
    (newline-output-stream)
    (while (not (eof-reached-p input-stream))
      (write (read input-stream) (make-hash-table :test 'equal))
      (newline-output-stream)
      (write-string "(jt1> " output-stream)
      (newline-output-stream)))
  (close-input-stream input-stream)
  (close-output-stream output-stream)
  (terpri output-stream))

(repl)

;; Read a character from the input stream.
(defun read-char (input-stream)
  (char->integer (read-char-no-hang input-stream)))
  ;; Read a character from the input stream without blocking.
  (defun read-char-no-hang (input-stream)
  (let ((char (read-char input-stream)))
      (if (char-ready input-stream)
          char
          (read-char-no-hang input-stream))))
          ;; Read an expression from the input stream.
          (defun read (input-stream)
          (let ((char (read-char input-stream)))
              (cond ((char #\()) nil)
                    ((eq? char #\(') (read-list input-stream))
                    ((char-number? char) (number->string char))
                    (t (string char)))))
                    (defun read-list (input-stream)
                    (let ((expr (read input-stream)))
                        (cond ((null? expr) nil)
                              ((eq? expr #\)) (read input-stream))
                              (t (cons (eval expr env) (read-list input-stream))))))
                    (cond ((eq? char #\()) nil)
                      ((eq? char #\(') (read-list input-stream))
                      ((char-number? char) (number->string char))
                      (t (string char)))))
                      ;; Write a character to the output stream.
                      (defun write-char (char output-stream)
                      (write-string (char->string char) output-stream))
                      ;; Evaluate an expression and print its result.
                      (defun write (expr env)
                      (write-char #\(' output-stream)
                      (write expr env)
                      (write-char #\) output-stream)
                      (newline-output-stream))
                      ;; Evaluate an expression and return its result.
                      (defun eval (expr env)
                      (cond ((symbol? expr) (get expr env))
                            ((number? expr) expr)
                            ((string? expr) expr)
                            ((list? expr) (let ((op (car expr)))
                                                (cond ((eq? op 'quote) (cdr expr))
                                                      ((eq? op 'if) (let ((cond-expr (car (cdr expr))))
                                                           (if (eval cond-expr env)
                                                               (eval (car (cddr (cddr expr))) env)
                                                               (eval (car (cddr expr)) env))))
                                                               ((eq? op 'lambda) (lambda (parms . body) (list 'fn parms body)))
                                                               ((eq? op 'define) (set! (car (cdr expr)) (eval (cddr expr) env)))
                                                               ((eq? op 'set!) (set! (car (cddr expr)) (eval (cadr expr) env)))
                                                               ((eq? op 'begin) (eval (car expr) env) (eval (cddr expr) env))
                                                               ((eq? op 'and) (let ((result t))
                                                                (map (lambda (x) (set! result (and result (eval x env)))) (cdr expr))
                                                                result))
                                                                 ((eq? op 'or) (let ((result nil))
                                                                 (map (lambda (x) (set! result (or result (eval x env)))) (cdr expr))
                                                                 result))
                                                                 (eq? op 'not) (not (eval (car (cdr expr)) env))))
                                                                 (t (eval (car expr) env) (apply (car (cdr expr)) (map eval (cdr (cdr expr))))))))
                                                                 (write expr env)
                                                                 (newline-output-stream))))
                                                                 (write-char #\))
                                                                 (newline-output-stream)))
                                                                 (read-char input-stream)
                                                                 (let ((expr (read-list input-stream)))
                                                                   (write expr env)
                                                                   (newline-output-stream)
                                                                   (eval expr env))))
                                                                   (t (write-char #\')
                                                                   (write expr env)
                                                                   (write-char #\)
                                                                   (newline-output-stream))))
                                                                   (read-char input-stream)
                                                                   (let ((expr (read input-stream)))
                                                                     (write expr env)
                                                                     (newline-output-stream)
                                                                     (eval expr env))))

;; Evaluate the given expression and print its result.
(defun repl ()
  (let ((input-stream (open-input-string ""))
  (output-stream (open-output-string)))
  (write-string "(jt1> " output-stream)
    (newline-output-stream)
    (while (not (eof-reached-p input-stream))
      (write (read input-stream) (make-hash-table :test 'equal))
      (newline-output-stream)
      (write-string "(jt1> " output-stream)
      (newline-output-stream)))
  (close-input-stream input-stream)
  (close-output-stream output-stream)
  (terpri output-stream))

(repl)

;; Read a character from the input stream.
(defun read-char (input-stream)
  (char->integer (read-char-no-hang input-stream)))
  ;; Read a character from the input stream without blocking.
  (defun read-char-no-hang (input-stream)
  (let ((char (read-char input-stream)))
      (if (char-ready input-stream)
          char
          (read-char-no-hang input-stream))))
          ;; Read an expression from the input stream.
          (defun read (input-stream)
          (let ((char (read-char input-stream)))
              (cond ((char #\()) nil)
                    ((eq? char #\(') (read-list input-stream))
                    ((char-number? char) (number->string char))
                    (t (string char)))))
                    (defun read-list (input-stream)
                    (let ((expr (read input-stream)))
                        (cond ((null? expr) nil)
                              ((eq? expr #\)) (read input-stream))
                              (t (cons (eval expr env) (read-list input-stream))))))
                    (cond ((eq? char #\()) nil)
                      ((eq? char #\(') (read-list input-stream))
                      ((char-number? char) (number->string char))
                      (t (string char)))))
                      ;; Write a character to the output stream.
                      (defun write-char (char output-stream)
                      (write-string (char->string char) output-stream))
                      ;; Evaluate an expression and print its result.
                      (defun write (expr env)
                      (write-char #\(' output-stream)
                      (write expr env)
                      (write-char #\) output-stream)
                      (newline-output-stream))
                      ;; Evaluate an expression and return its result.
                      (defun eval (expr env)
                      (cond ((symbol? expr) (get expr env))
                            ((number? expr) expr)
                            ((string? expr) expr)
                            ((list? expr) (let ((op (car expr)))
                                                (cond ((eq? op 'quote) (cdr expr))
                                                      ((eq? op 'if) (let ((cond-expr (car (cdr expr))))
                                                           (if (eval cond-expr env)
                                                               (eval (car (cddr (cddr expr))) env)
                                                               (eval (car (cddr expr)) env))))
                                                               ((eq? op 'lambda) (lambda (parms . body) (list 'fn parms body)))
                                                               ((eq? op 'define) (set! (car (cdr expr)) (eval (cddr expr) env)))
                                                               ((eq? op'set!) (set! (car (cddr expr)) (eval (cadr expr) env)))
                                                               ((eq? op 'begin) (eval (car expr) env) (eval (cddr expr) env))
                                                               ((eq? op 'and) (let ((result t))
                                                                (map (lambda (x) (set! result (and result (eval x env)))) (cdr expr))
                                                                result))
                                                                 ((eq? op 'or) (let ((result nil))
                                                                 (map (lambda (x) (set! result (or result (eval x env)))) (cdr expr))
                                                                 result))
                                                                 (eq? op 'not) (not (eval (car (cdr expr)) env))))
                                                                 (t (eval (car expr) env) (apply (car (cdr expr)) (map eval (cdr (cdr expr))))))))
                                                                 (write expr env)
                                                                 (newline-output-stream))))
                                                                 (write-char #\))
                                                                 (newline-output-stream)))
                                                                 (read-char input-stream)
                                                                 (let ((expr (read-list input-stream)))
                                                                   (write expr env)
                                                                   (newline-output-stream)
                                                                   (eval expr env))))
                                                                   (t (write-char #\')
                                                                   (write expr env)
                                                                   (write-char #\)
                                                                   (newline-output-stream))))
                                                                   (read-char input-stream)
                                                                   (let ((expr (read input-stream)))
                                                                     (write expr env)
                                                                     (newline-output-stream)
                                                                     (eval expr env))))

;; Evaluate the given expression and print its result.
(defun repl ()
  (let ((input-stream (open-input-string ""))
  (output-stream (open-output-string)))
  (write-string "(jt1> " output-stream)
    (newline-output-stream)
    (while (not (eof-reached-p input-stream))
      (write (read input-stream) (make-hash-table :test 'equal))
      (newline-output-stream)
      (write-string "(jt1> " output-stream)
      (newline-output-stream)))
      (close-input-stream input-stream)
      (close-output-stream output-stream)
      (terpri output-stream))

(repl)

;; Read a character from the input stream.
(defun read-char (input-stream)
  (char->integer (read-char-no-hang input-stream)))
  ;; Read a character from the input stream without blocking.
  (defun read-char-no-hang (input-stream)
  (let ((char (read-char input-stream)))
      (if (char-ready input-stream)
          char
          (read-char-no-hang input-stream))))
          ;; Read an expression from the input stream.
          (defun read (input-stream)
          (let ((char (read-char input-stream)))
              (cond ((char #\()) nil)
                    ((eq? char #\(') (read-list input-stream))
                    ((char-number? char) (number->string char))
                    (t (string char)))))
                    (defun read-list (input-stream)
                    (let ((expr (read input-stream)))
                        (cond ((null? expr) nil)
                              ((eq? expr #\)) (read input-stream))
                              (t (cons (eval expr env) (read-list input-stream))))))
                    (cond ((eq? char #\()) nil)
                      ((eq? char #\(') (read-list input-stream))
                      ((char-number? char) (number->string char))
                      (t (string char)))))
                      ;; Write a character to the output stream.
                      (defun write-char (char output-stream)
                      (write-string (char->string char) output-stream))
                      ;; Evaluate an expression and print its result.
                      (defun write (expr env)
                      (write-char #\(' output-stream)
                      (write expr env)
                      (write-char #\) output-stream)
                      (newline-output-stream))
                      ;; Evaluate an expression and return its result.
                      (defun eval (expr env)
                      (cond ((symbol? expr) (get expr env))
                            ((number? expr) expr)
                            ((string? expr) expr)
                            ((list? expr) (let ((op (car expr)))
                                                (cond ((eq? op 'quote) (cdr expr))
                                                      ((eq? op 'if) (let ((cond-expr (car (cdr expr))))
                                                           (if (eval cond-expr env)
                                                               (eval (car (cddr (cddr expr))) env)
                                                               (eval (car (cddr expr)) env))))
                                                               ((eq? op 'lambda) (lambda (parms . body) (list 'fn parms body)))
                                                               ((eq? op 'define) (set! (car (cdr expr)) (eval (cddr expr) env)))
                                                               ((eq? op'set!) (set! (car (cddr expr)) (eval (cadr expr) env)))
                                                               ((eq? op 'begin) (eval (car expr) env) (eval (cddr expr) env))
                                                               ((eq? op 'and) (let ((result t))
                                                                (map (lambda (x) (set! result (and result (eval x env)))) (cdr expr))
                                                                result))
                                                                 ((eq? op 'or) (let ((result nil))
                                                                 (map (lambda (x) (set! result (or result (eval x env)))) (cdr expr))
                                                                 result))
                                                                 (eq? op 'not) (not (eval (car (cdr expr)) env))))
                                                                 (t (eval (car expr) env) (apply (car (cdr expr)) (map eval (cdr (cdr expr))))))))
                                                                 (write expr env)
                                                                 (newline-output-stream))))
                                                                 (write-char #\))
                                                                 (newline-output-stream)))
                                                                 (read-char input-stream)
                                                                 (let ((expr (read-list input-stream)))
                                                                   (write expr env)
                                                                   (newline-output-stream)
                                                                   (eval expr env))))
                                                                   (t (write-char #\')
                                                                   (write expr env)
                                                                   (write-char #\)
                                                                   (newline-output-stream))))
                                                                   (read-char input-stream)
                                                                   (let ((expr (read input-stream)))
                                                                     (write expr env)
                                                                     (newline-output-stream)
                                                                     (eval expr env))))

;; Evaluate the given expression and print its result.
(defun repl ()
  (let ((input-stream (open-input-string ""))
  (output-stream (open-output-string)))
  (write-string "(jt1> " output-stream)
    (newline-output-stream)
    (while (not (eof-reached-p input-stream))
      (write (read input-stream) (make-hash-table :test 'equal))
      (newline-output-stream)
      (write-string "(jt1> " output-stream)
      (newline-output-stream)))
      (close-input-stream input-stream)
      (close-output-stream output-stream)
      (terpri output-stream))

(repl)
;; Read a character from the input stream.
(defun read-char (input-stream)
  (char->integer (read-char-no-hang input-stream)))
  ;; Read a character from the input stream without blocking.
  (defun read-char-no-hang (input-stream)
  (let ((char (read-char input-stream)))
      (if (char-ready input-stream)
          char
          (read-char-no-hang input-stream))))
          ;; Read an expression from the input stream.
          (defun read (input-stream)
          (let ((char (read-char input-stream)))
              (cond ((char #\()) nil)
                    ((eq? char #\(') (read-list input-stream))
                    ((char-number? char) (number->string char))
                    (t (string char)))))
                    (defun read-list (input-stream)
                    (let ((expr (read input-stream)))
                        (cond ((null? expr) nil)
                              ((eq? expr #\)) (read input-stream))
                              (t (cons (eval expr env) (read-list input-stream))))))
                    (cond ((eq? char #\()) nil)
                      ((eq? char #\(') (read-list input-stream))
                      ((char-number? char) (number->string char))
                      (t (string char)))))
                      ;; Write a character to the output stream.
                      (defun write-char (char output-stream)
                      (write-string (char->string char) output-stream))
                      ;; Evaluate an expression and print its result.
                      (defun write (expr env)
                      (write-char #\(' output-stream)
                      (write expr env)
                      (write-char #\) output-stream)
                      (newline-output-stream))
                      ;; Evaluate an expression and return its result.
                      (defun eval (expr env)
                      (cond ((symbol? expr) (get expr env))
                            ((number? expr) expr)
                            ((string? expr) expr)
                            ((list? expr) (let ((op (car expr)))
                                                (cond ((eq? op 'quote) (cdr expr))
                                                          ((eq? op 'if) (let ((cond-expr (car (cdr expr))))
                                                           (if (eval cond-expr env)
                                                               (eval (car (cddr (cddr expr))) env)
                                                               (eval (car (cddr expr)) env))))
                                                               ((eq? op 'lambda) (lambda (parms . body) (list 'fn parms body)))
                                                               ((eq? op 'define) (set! (car (cdr expr)) (eval (cddr expr) env)))
                                                               ((eq? op'set!) (set! (car (cddr expr)) (eval (cadr expr) env)))
                                                               ((eq? op 'begin) (eval (car expr) env) (eval (cddr expr) env))
                                                               ((eq? op 'and) (let ((result t))
                                                                (map (lambda (x) (set! result (and result (eval x env)))) (cdr expr))
                                                                result))
                                                                 ((eq? op 'or) (let ((result nil))
                                                                 (map (lambda (x) (set! result (or result (eval x env)))) (cdr expr))
                                                                 result))
                                                                 (eq? op 'not) (not (eval (car (cdr expr)) env))))
                                                                 (t (eval (car expr) env) (apply (car (cdr expr)) (map eval (cdr (cdr expr))))))))
                                                                 (write expr env)
                                                                 (newline-output-stream))))
                                                                 (write-char #\))
                                                                 (write-char #\)
                                                                 (newline-output-stream)))
                                                                 (read-char input-stream)
                                                                 (let ((expr (read-list input-stream)))
                                                                   (write expr env)
                                                                   (newline-output-stream)
                                                                   (eval expr env))))
                                                                   (t (write-char #\')
                                                                   (write expr env)
                                                                   (write-char #\)
                                                                   (newline-output-stream))))
                                                                   (read-char input-stream)
                                                                   (let ((expr (read input-stream)))
                                                                     (write expr env)
                                                                     (newline-output-stream)
                                                                     (eval expr env))))

;; Evaluate the given expression and print its result.
(defun repl ()
  (let ((input-stream (open-input-string ""))
  (output-stream (open-output-string)))
  (write-string "(jt1> " output-stream)
    (newline-output-stream)
    (while (not (eof-reached-p input-stream))
      (write (read input-stream) (make-hash-table :test 'equal))
      (newline-output-stream)
      (write-string "(jt1> " output-stream)
      (newline-output-stream)))
      (close-input-stream input-stream)
      (close-output-stream output-stream)
      (terpri output-stream))

(repl)
;; Read a character from the input stream.
(defun read-char (input-stream)
  (char->integer (read-char-no-hang input-stream)))
  ;; Read a character from the input stream without blocking.
  (defun read-char-no-hang (input-stream)
  (let ((char (read-char input-stream)))
      (if (char-ready input-stream)
          char
          (read-char-no-hang input-stream))))
          ;; Read an expression from the input stream.
          (defun read (input-stream)
          (let ((char (read-char input-stream)))
              (cond ((char #\()) nil)
                    ((eq? char #\(') (read-list input-stream))
                    ((char-number? char) (number->string char))
                    (t (string char)))))
                    (defun read-list (input-stream)
                    (let ((expr (read input-stream)))
                        (cond ((null? expr) nil)
                              ((eq? expr #\)) (read input-stream))
                              (t (cons (eval expr env) (read-list input-stream))))))
                    (cond ((eq? char #\()) nil)
                      ((eq? char #\(') (read-list input-stream))
                      ((char-number? char) (number->string char))
                      (t (string char)))))
                      ;; Write a character to the output stream.
                      (defun write-char (char output-stream)
                      (write-string (char->string char) output-stream))
                      ;; Evaluate an expression and print its result.
                      (defun write (expr env)
                      (write-char #\(' output-stream)
                      (write expr env)
                      (write-char #\) output-stream)
                      (newline-output-stream))
                      ;; Evaluate an expression and return its result.
                      (defun eval (expr env)
                      (cond ((symbol? expr) (get expr env))
                            ((number? expr) expr)
                            ((string? expr) expr)
                            ((list? expr) (let ((op (car expr)))
                                                (cond ((eq? op 'quote) (cdr expr))
                                                          ((eq? op 'if) (let ((cond-expr (car (cdr expr))))
                                                           (if (eval cond-expr env)
                                                               (eval (car (cddr (cddr expr))) env)
                                                               (eval (car (cddr expr)) env))))
                                                               ((eq? op 'lambda) (lambda (parms . body) (list 'fn parms body)))
                                                               ((eq? op 'define) (set! (car (cdr expr)) (eval (cddr expr) env)))
                                                               ((eq? op'set!) (set! (car (cddr expr)) (eval (cadr expr) env)))
                                                               ((eq? op 'begin) (eval (car expr) env) (eval (cddr expr) env))
                                                               ((eq? op 'and) (let ((result t))
                                                                (map (lambda (x) (set! result (and result (eval x env)))) (cdr expr))
                                                                result))
                                                                 ((eq? op 'or) (let ((result nil))
                                                                 (map (lambda (x) (set! result (or result (eval x env)))) (cdr expr))
                                                                 result))
                                                                 (eq? op 'not) (not (eval (car (cdr expr)) env))))
                                                                 (t (eval (car expr) env) (apply (car (cdr expr)) (map eval (cdr (cdr expr))))))))
                                                                 (write expr env)
                                                                 (newline-output-stream))))
                                                                 (write-char #\))
                                                                 (write-char #\)
                                                                 (newline-output-stream)))
                                                                 (read-char input-stream)
                                                                 (let ((expr (read-list input-stream)))
                                                                   (write expr env)
                                                                   (newline-output-stream)
                                                                   (eval expr env))))
                                                                   (t (write-char #\')
                                                                   (write expr env)
                                                                   (write-char #\)
                                                                   (newline-output-stream))))
                                                                   (read-char input-stream)
                                                                   (let ((expr (read input-stream)))
                                                                     (write expr env)
                                                                     (newline-output-stream)
                                                                     (eval expr env))))

;; Evaluate the given expression and print its result.
(defun repl ()
  (let ((input-stream (open-input-string ""))
  (output-stream (open-output-string)))
  (write-string "(jt1> " output-stream)
    (newline-output-stream)
    (while (not (eof-reached-p input-stream))
      (write (read input-stream) (make-hash-table :test 'equal))
      (newline-output-stream)
      (write-string "(jt1> " output-stream)
      (newline-output-stream)))
      (close-input-stream input-stream)
      (close-output-stream output-stream)
      (terpri output-stream))

(repl)
;; Read a character from the input stream.
(defun read-char (input-stream)
  (char->integer (read-char-no-hang input-stream)))
  ;; Read a character from the input stream without blocking.
  (defun read-char-no-hang (input-stream)
  (let ((char (read-char input-stream)))
      (if (char-ready input-stream)
          char
          (read-char-no-hang input-stream))))
          ;; Read an expression from the input stream.
          (defun read (input-stream)
          (let ((char (read-char input-stream)))
              (cond ((char #\()) nil)
                    ((eq? char #\(') (read-list input-stream))
                    ((char-number? char) (number->string char))
                    (t (string char)))))
                    (defun read-list (input-stream)
                    (let ((expr (read input-stream)))
                        (cond ((null? expr) nil)
                              ((eq? expr #\)) (read input-stream))
                              (t (cons (eval expr env) (read-list input-stream))))))
                    (cond ((eq? char #\()) nil)
                      ((eq? char #\(') (read-list input-stream))
                      ((char-number? char) (number->string char))
                      (t (string char)))))
                      ;; Write a character to the output stream.
                      (defun write-char (char output-stream)
                      (write-string (char->string char) output-stream))
                      ;; Evaluate an expression and print its result.
                      (defun write (expr env)
                      (write-char #\(' output-stream)
                      (write expr env)
                      (write-char #\) output-stream)
                      (newline-output-stream))
                      ;; Evaluate an expression and return its result.
                      (defun eval (expr env)
                      (cond ((symbol? expr) (get expr env))
                            ((number? expr) expr)
                            ((string? expr) expr)
                            ((list? expr) (let ((op (car expr)))
                                                (cond ((eq? op 'quote) (cdr expr))
                                                          ((eq? op 'if) (let ((cond-expr (car (cdr expr))))
                                                           (if (eval cond-expr env) 
                                                           (eval (car (cddr (cddr expr))) env)
                                                           (eval (car (cddr expr)) env))))
                                                               ((eq? op 'lambda) (lambda (parms . body) (list 'fn parms body)))
                                                               ((eq? op 'define) (set! (car (cdr expr)) (eval (cddr expr) env)))
                                                               ((eq? op'set!) (set! (car (cddr expr)) (eval (cadr expr) env)))
                                                               ((eq? op 'begin) (eval (car expr) env) (eval (cddr expr) env))
                                                               ((eq? op 'and) (let ((result t))
                                                                (map (lambda (x) (set! result (and result (eval x env)))) (cdr expr))
                                                                result))
                                                                 ((eq? op 'or) (let ((result nil))
                                                                 (map (lambda (x) (set! result (or result (eval x env)))) (cdr expr))
                                                                 result))
                                                                 (eq? op 'not) (not (eval (car (cdr expr)) env))))
                                                                 (t (eval (car expr) env) (apply (car (cdr expr)) (map eval (cdr (cdr expr))))))))
                                                                 (write expr env)
                                                                 (newline-output-stream))))
                                                                 (write-char #\))
                                                                 (write-char #\)
                                                                 (newline-output-stream)))
                                                                 (read-char input-stream)
                                                                 (let ((expr (read-list input-stream)))
                                                                   (write expr env)
                                                                   (newline-output-stream)
                                                                   (eval expr env))))
                                                                   (t (write-char #\')
                                                                   (write expr env)
                                                                   (write-char #\)
                                                                   (newline-output-stream))))
                                                                   (read-char input-stream)
                                                                   (let ((expr (read input-stream)))
                                                                     (write expr env)
                                                                     (newline-output-stream)
                                                                     (eval expr env))))
                                                                     ;; Evaluate the given expression and print its result.
                                                                     (defun repl ()
                                                                     (let ((input-stream (open-input-string ""))
                                                                     (output-stream (open-output-string)))
                                                                     (write-string "(jt1> " output-stream)
                                                                     (newline-output-stream)
                                                                     (while (not (eof-reached-p input-stream))
                                                                       (write (read input-stream) (make-hash-table :test 'equal))
                                                                       (newline-output-stream)
                                                                       (write-string "(jt1> " output-stream)
                                                                       (newline-output-stream)))
                                                                       (close-input-stream input-stream)
                                                                       (close-output-stream output-stream)
                                                                       (terpri output-stream))
                                                                     (repl)
                                                                     ;; Read a character from the input stream.
                                                                     (defun read-char (input-stream)
                                                                     (char->integer (read-char-no-hang input-stream)))
                                                                       ;; Read a character from the input stream without blocking.
                                                                       (defun read-char-no-hang (input-stream)
                                                                       (let ((char (read-char input-stream)))
                                                                           (if (char-ready input-stream)
                                                                               char
                                                                               (read-char-no-hang input-stream))))
                                                                               ;; Read an expression from the input stream.
                                                                               (defun read (input-stream)
                                                                               (let ((char (read-char input-stream)))
                                                                               (cond ((eq? char #\') (read-list input-stream))
                                                                                     ((char-number? char) (number->string char))
                                                                                     (t (string char)))))
                                                                                     ;; Read a list from the input stream.
                                                                                     (defun read-list (input-stream)
                                                                                     (let ((char (read-char input-stream)))
                                                                                     (cond ((eq? char #\))
                                                                                       nil
                                                                                       ((eq? char #\))
                                                                                       (cons (read input-stream) (read-list input-stream)))
                                                                                       (t (cons (read input-stream) (read-list input-stream)))))
                                                                                       ;; Read a string from the input stream.
                                                                                       (defun read-string (input-stream)
                                                                                       (let ((char (read-char input-stream)))
                                                                                       (cond ((eq? char #\")
                                                                                       (let ((result ""))
                                                                                         (do ()
                                                                                           (cond ((eq? (read-char input-stream) #\")
                                                                                               (string-append result (read-char input-stream)))
                                                                                             ((eq? (read-char input-stream) #\))
                                                                                               result))
                                                                                               ((char-ready input-stream)
                                                                                               (string-append result (read-char-no-hang input-stream)))
                                                                                               (else
                                                                                               (read-string input-stream))))
                                                                                       ((char-ready input-stream)
                                                                                       (read-char-no-hang input-stream))
                                                                                       (else
                                                                                       (read-string input-stream))))
                                                                                       ;; Evaluate the given expression and print its result.
                                                                                       (defun eval (expr env)
                                                                                       (let ((result (eval expr env)))
                                                                                         (write result (make-hash-table :test 'equal))
                                                                                         (newline-output-stream)
                                                                                         (t result)))
                                                                                         ;; Read a character from the input stream.
                                                                                         (defun read-char (input-stream)
                                                                                         (char->integer (read-char-no-hang input-stream)))
                                                                                         ;; Read a character from the input stream without blocking.
                                                                                         (defun read-char-no-hang (input-stream)
                                                                                         (let ((char (read-char input-stream)))
                                                                                             (if (char-ready input-stream)
                                                                                             char
                                                                                             (read-char-no-hang input-stream))))
                                                                                             ;; Read an expression from the input stream.
                                                                                             (defun read (input-stream)
                                                                                             (let ((char (read-char input-stream)))
                                                                                             (cond ((eq? char #\') (read-list input-stream))
                                                                                     ((char-number? char) (number->string char))
                                                                                     (t (string char)))))
                                                                                     ;; Read a list from the input stream.
                                                                                     (defun read-list (input-stream)
                                                                                     (let ((char (read-char input-stream)))
                                                                                     (cond ((eq? char #\))
                                                                                       nil
                                                                                       ((eq? char #\))
                                                                                       (cons (read input-stream) (read-list input-stream)))
                                                                                       (t (cons (read input-stream) (read-list input-stream)))))
                                                                                       ;; Read a string from the input stream.
                                                                                       (defun read-string (input-stream)
                                                                                       (let ((char (read-char input-stream)))
                                                                                       (cond ((eq? char #\")
                                                                                       (let ((result ""))
                                                                                         (do ()
                                                                                           (cond ((eq? (read-char input-stream) #\")
                                                                                               (string-append result (read-char input-stream)))
                                                                                             ((eq? (read-char input-stream) #\))
                                                                                               result))
                                                                                               ((char-ready input-stream)
                                                                                               (string-append result (read-char-no-hang input-stream)))
                                                                                               (else
                                                                                               (read-string input-stream))))
                                                                                       ((char-ready input-stream)
                                                                                       (read-char-no-hang input-stream))
                                                                                       (else
                                                                                       (read-string input-stream))))
                                                                                       ;; Evaluate the given expression and print its result.
                                                                                       (defun eval (expr env)
                                                                                       (let ((result (eval expr env)))
                                                                                         (write result (make-hash-table :test 'equal))
                                                                                         (newline-output-stream)
                                                                                         (t result)))
                                                                                         ;; Read a character from the input stream.
                                                                                         (defun read-char (input-stream)
                                                                                         (char->integer (read-char-no-hang input-stream)))
                                                                                         ;; Read a character from the input stream without blocking.
                                                                                         (defun read-char-no-hang (input-stream)
                                                                                         (let ((char (read-char input-stream)))
                                                                                             (if (char-ready input-stream)
                                                                                             char
                                                                                             (read-char-no-hang input-stream))))
                                                                                             ;; Read an expression from the input stream.

                                                                                               (defun read (input-stream)
                                                                                               (let ((char (read-char input-stream)))
                                                                                               (cond ((eq? char #\') (read-list input-stream))
                                                                                     ((char-number? char) (number->string char))
                                                                                     (t (string char)))))
                                                                                     ;; Read a list from the input stream.
                                                                                     (defun read-list (input-stream)
                                                                                     (let ((char (read-char input-stream)))
                                                                                     (cond ((eq? char #\))
                                                                                       nil
                                                                                       ((eq? char #\))
                                                                                       (cons (read input-stream) (read-list input-stream)))
                                                                                       (t (cons (read input-stream) (read-list input-stream)))))
                                                                                       ;; Read a string from the input stream.
                                                                                       (defun read-string (input-stream)
                                                                                       (let ((char (read-char input-stream)))
                                                                                       (cond ((eq? char #\")
                                                                                       (let ((result ""))
                                                                                         (do ()
                                                                                           (cond ((eq? (read-char input-stream) #\")
                                                                                               (string-append result (read-char input-stream)))
                                                                                             ((eq? (read-char input-stream) #\))
                                                                                               result))
                                                                                               ((char-ready input-stream)
                                                                                               (string-append result (read-char-no-hang input-stream)))
                                                                                               (else
                                                                                               (read-string input-stream))))
                                                                                       ((char-ready input-stream)
                                                                                       (read-char-no-hang input-stream))
                                                                                       (else
                                                                                       (read-string input-stream))))
                                                                                       ;; Evaluate the given expression and print its result.
                                                                                       (defun eval (expr env)
                                                                                       (let ((result (eval expr env)))
                                                                                         (write result (make-hash-table :test 'equal))
                                                                                         (newline-output-stream)
                                                                                         (t result)))
                                                                                         ;; Read a character from the input stream.
                                                                                         (defun read-char (input-stream)
                                                                                         (char->integer (read-char-no-hang input-stream)))
                                                                                         ;; Read a character from the input stream without blocking.
                                                                                         (defun read-char-no-hang (input-stream)
                                                                                         (let ((char (read-char input-stream)))
                                                                                             (if (char-ready input-stream)
                                                                                             char
                                                                                             (read-char-no-hang input-stream))))
                                                                                             ;; Read an expression from the input stream.
                                                                                               (defun read (input-stream)
                                                                                               (let ((char (read-char input-stream)))
                                                                                               (cond ((eq? char #\') (read-list input-stream))
                                                                                     ((char-number? char) (number->string char))
                                                                                     (t (string char)))))
                                                                                     ;; Read a list from the input stream.
                                                                                     (defun read-list (input-stream)
                                                                                     (let ((char (read-char input-stream)))
                                                                                     (cond ((eq? char #\))
                                                                                       nil
                                                                                       ((eq? char #\))
                                                                                       (cons (read input-stream) (read-list input-stream)))
                                                                                       (t (cons (read input-stream) (read-list input-stream)))))
                                                                                       ;; Read a string from the input stream.
                                                                                       (defun read-string (input-stream)
                                                                                       (let ((char (read-char input-stream)))
                                                                                       (cond ((eq? char #\")
                                                                                       (let ((result ""))
                                                                                         (do ()
                                                                                           (cond ((eq? (read-char input-stream) #\")
                                                                                               (string-append result (read-char input-stream)))
                                                                                             ((eq? (read-char input-stream) #\))
                                                                                               result))
                                                                                               ((char-ready input-stream)
                                                                                               (string-append result (read-char-no-hang input-stream)))
                                                                                               (else
                                                                                               (read-string input-stream))))
                                                                                       ((char-ready input-stream)
                                                                                       (read-char-no-hang input-stream))
                                                                                       (else
                                                                                       (read-string input-stream))))
                                                                                       ;; Evaluate the given expression and print its result.
                                                                                       (defun eval (expr env)
                                                                                       (let ((result (eval expr env)))
                                                                                         (write result (make-hash-table :test 'equal))
                                                                                         (newline-output-stream)
                                                                                         (t result)))
                                                                                         ;; Read a character from the input stream.
                                                                                         (defun read-char (input-stream)
                                                                                         (char->integer (read-char-no-hang input-stream)))
                                                                                         ;; Read a character from the input stream without blocking.
                                                                                         (defun read-char-no-hang (input-stream)
                                                                                         (let ((char (read-char input-stream)))
                                                                                             (if (char-ready input-stream)
                                                                                             char
                                                                                             (read-char-no-hang input-stream))))
                                                                                             ;; Read an expression from the input stream.
                                                                                               (defun read (input-stream)
                                                                                               (let ((char (read-char input-stream)))
                                                                                               (cond ((eq? char #\') (read-list input-stream))
                                                                                     ((char-number? char) (number->string char))
                                                                                     (t (string char)))))
                                                                                     ;; Read a list from the input stream.
                                                                                     (defun read-list (input-stream)
                                                                                     (let ((char (read-char input-stream)))
                                                                                     (cond ((eq? char #\))
                                                                                       nil
                                                                                       ((eq? char #\))
                                                                                       (cons (read input-stream) (read-list input-stream)))
                                                                                       (t (cons (read input-stream) (read-list input-stream)))))
                                                                                       ;; Read a string from the input stream.
                                                                                     (defun read-string (input-stream)
                                                                                     (let ((char (read-char input-stream)))
                                                                                     (cond ((eq? char #\")
                                                                                       (let ((result ""))
                                                                                         (do ()
                                                                                           (cond ((eq? (read-char input-stream) #\")
                                                                                               (string-append result (read-char input-stream)))
                                                                                             ((eq? (read-char input-stream) #\))
                                                                                               result))
                                                                                               ((char-ready input-stream)
                                                                                               (string-append result (read-char-no-hang input-stream)))
                                                                                               (else
                                                                                               (read-string input-stream))))
                                                                                       ((char-ready input-stream)
                                                                                       (read-char-no-hang input-stream))
                                                                                       (else
                                                                                       (read-string input-stream))))
                                                                                       ;; Evaluate the given expression and print its result.
                                                                                     (defun eval (expr env)
                                                                                     (let ((result (eval expr env)))
                                                                                       (write result (make-hash-table :test 'equal))
                                                                                       (newline-output-stream)
                                                                                       (t result)))
                                                                                       ;; Read a character from the input stream.
                                                                                     (defun read-char (input-stream)
                                                                                     (char->integer (read-char-no-hang input-stream)))
                                                                                       ;; Read a character from the input stream without blocking.
                                                                                       (defun read-char-no-hang (input-stream)
                                                                                       (let ((char (read-char input-stream)))
                                                                                             (if (char-ready input-stream)
                                                                                             char
                                                                                             (read-char-no-hang input-stream))))
                                                                                             ;; Read an expression from the input stream.
                                                                                       (defun read (input-stream)
                                                                                       (let ((char (read-char input-stream)))
                                                                                       (cond ((eq? char #\') (read-list input-stream))
                                                                                       ((char-number? char) (number->string char))
                                                                                       (t (string char)))))
                                                                                       ;; Read a list from the input stream.
                                                                                     (defun read-list (input-stream)
                                                                                     (let ((char (read-char input-stream)))
                                                                                     (cond ((eq? char #\))
                                                                                       nil
                                                                                       ((eq? char #\))
                                                                                       (cons (read input-stream) (read-list input-stream)))
                                                                                       (t (cons (read input-stream) (read-list input-stream)))))
                                                                                       ;; Read a string from the input stream.
                                                                                     (defun read-string (input-stream)
                                                                                     (let ((char (read-char input-stream)))
                                                                                     (cond ((eq? char #\")
                                                                                       (let ((result ""))
                                                                                         (do ()
                                                                                           (cond ((eq? (read-char input-stream) #\")
                                                                                               (string-append result (read-char input-stream)))
                                                                                             ((eq? (read-char input-stream) #\))
                                                                                               result))
                                                                                               ((char-ready input-stream)
                                                                                               (string-append result (read-char-no-hang input-stream)))
                                                                                               (else
                                                                                               (read-string input-stream))))
                                                                                       ((char-ready input-stream)
                                                                                       (read-char-no-hang input-stream))
                                                                                       (else
                                                                                       (read-string input-stream))))
                                                                                       ;; Evaluate the given expression and print its result.
                                                                                     (defun eval (expr env)
                                                                                     (let ((result (eval expr env)))
                                                                                       (write result (make-hash-table :test 'equal))
                                                                                       (newline-output-stream)
                                                                                       (t result)))
                                                                                       ;; Read a character from the input stream.
                                                                                     (defun read-char (input-stream)
                                                                                     (char->integer (read-char-no-hang input-stream)))
                                                                                       ;; Read a character from the input stream without blocking.
                                                                                       (defun read-char-no-hang (input-stream)
                                                                                       (let ((char (read-char input-stream)))
                                                                                             (if (char-ready input-stream)
                                                                                             char
                                                                                             (read-char-no-hang input-stream))))
                                                                                             ;; Read an expression from the input stream.
                                                                                       (defun read (input-stream)
                                                                                       (let ((char (read-char input-stream)))
                                                                                       (cond ((eq? char #\') (read-list input-stream))
                                                                                       ((char-number? char) (number->string char))
                                                                                       (t (string char)))))
                                                                                       ;; Read a list from the input stream.
                                                                                       (defun read-list (input-stream)
                                                                                       (let ((char (read-char input-stream)))
                                                                                     (cond ((eq? char #\))
                                                                                       nil
                                                                                       ((eq? char #\))
                                                                                       (cons (read input-stream) (read-list input-stream)))
                                                                                       (t (cons (read input-stream) (read-list input-stream)))))
                                                                                       ;; Read a string from the input stream.
                                                                                       (defun read-string (input-stream)
                                                                                       (let ((char (read-char input-stream)))
                                                                                       (cond ((eq? char #\")
                                                                                       (let ((result ""))
                                                                                         (do ()
                                                                                           (cond ((eq? (read-char input-stream) #\")
                                                                                               (string-append result (read-char input-stream)))
                                                                                               ((eq? (read-char input-stream) #\))
                                                                                               result))
                                                                                               ((char-ready input-stream)
                                                                                               (string-append result (read-char-no-hang input-stream)))
                                                                                               (else
                                                                                               (read-string input-stream))))
                                                                                               ;; Evaluate the given expression and print its result.
                                                                                               (defun eval (expr env)
                                                                                               (let ((result (eval expr env)))
                                                                                                 (write result (make-hash-table :test 'equal))
                                                                                                 (newline-output-stream)
                                                                                                 (t result)))
                                                                                               ;; Read a character from the input stream.
                                                                                               (defun read-char (input-stream)
                                                                                               (char->integer (read-char-no-hang input-stream)))
                                                                                               ;; Read a character from the input stream without blocking.
                                                                                               (defun read-char-no-hang (input-stream)
                                                                                               (let ((char (read-char input-stream)))
                                                                                                (if (char-ready input-stream)
                                                                                                char
                                                                                                (read-char-no-hang input-stream))))
  

