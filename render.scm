(use-modules (ice-9 ftw))
(use-modules (ice-9 receive))
(use-modules (markdown))


(define (splitext name)
  (apply values (string-split name #\.)))


(define (md->html input)
  (let ((base (basename input))
        (dir (dirname input)))
    (receive (base _) (splitext base)
      (let ((output (string-append dir "/" base ".html")))
        (format #t "processing ~s\n" input)
        (with-input-from-file input
          (lambda ()
            (with-output-to-file output
              (lambda ()
                (main '())))))))))


(ftw "." (lambda (path _ type)
           (cond
            ((equal? type 'regular)
             (when (string-suffix? ".md" path)
               (md->html path))
             #true)
            ((equal? type 'directory) #true)
            (else #true))))
