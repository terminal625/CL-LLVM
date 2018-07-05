(in-package :k-shared)

;;; (2 3 4 5 6 7)
(defclass expression ()
  ()
  (:documentation "Base class for all expression nodes."))
(defclass number-expression (expression)
  ((value :initarg :value :reader value))
  (:documentation "Expression class for numeric literals like “1.0”."))
(defclass variable-expression (expression)
  ((name :initarg :name :reader name))
  (:documentation "Expression class for referencing a variable, like “a”."))
(defclass binary-expression (expression)
  ((operator :initarg :operator :reader operator)
   (lhs :initarg :lhs :reader lhs)
   (rhs :initarg :rhs :reader rhs))
  (:documentation "Expression class for a binary operator."))
(defclass call-expression (expression)
  ((callee :initarg :callee :reader callee)
   (arguments :initarg :arguments :reader arguments))
  (:documentation "Expression class for function calls."))
(defclass function-definition ()
  ((prototype :initarg :prototype :reader prototype)
   (body :initarg :body :reader body))
  (:documentation "This class represents a function definition itself."))

;;(2 3 4 5)
#+nil
(defclass prototype ()
  ((name :initform "" :initarg :name :reader name)
   (arguments :initform (make-array 0) :initarg :arguments :reader arguments))
  (:documentation
   "This class represents the “prototype” for a function, which captures its
    name, and its argument names (thus implicitly the number of arguments the
    function takes)."))

;;;6 7
(defclass prototype ()
  ((name :initform "" :initarg :name :reader name)
   (arguments :initform (make-array 0) :initarg :arguments :reader arguments)
   (operatorp :initform nil :initarg :operatorp :reader operatorp)
   (precedence :initform 0 :initarg :precedence :reader precedence))
  (:documentation
   "This class represents the “prototype” for a function, which captures its
    name, and its argument names (thus implicitly the number of arguments the
    function takes)."))

;;;5 6 7
(defclass if-expression (expression)
  ((_condition :initarg :_condition :reader _condition)
   (then :initarg :then :reader then)
   (else :initarg :else :reader else))
  (:documentation "Expression class for if/then/else."))
(defclass for-expression (expression)
  ((var-name :initarg :var-name :reader var-name)
   (start :initarg :start :reader start)
   (end :initarg :end :reader end)
   ;; FIXME: why is CCL's conflicting STEP visible here?
   (step :initarg :step :reader step*)
   (body :initarg :body :reader body))
  (:documentation "Expression class for for/in."))

;;;;6 7
(defclass unary-expression (expression)
  ((opcode :initarg :opcode :reader opcode)
   (operand :initarg :operand :reader operand))
  (:documentation "Expression class for a unary operator."))
(defmethod unary-operator-p ((expression prototype))
  (and (operatorp expression) (= (length (arguments expression)) 1)))
(defmethod binary-operator-p ((expression prototype))
  (and (operatorp expression) (= (length (arguments expression)) 2)))
(defmethod operator-name ((expression prototype))
  (assert (or (unary-operator-p expression) (binary-operator-p expression)))
  (elt (name expression) (1- (length (name expression)))))

;;;7
(defclass var-expression (expression)
  ((var-names :initarg :var-names :reader var-names)
   (body :initarg :body :reader body))
  (:documentation "Expression class for var/in"))