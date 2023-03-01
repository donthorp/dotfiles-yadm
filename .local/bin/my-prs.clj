#! /opt/bb/bb

;; Extract PRs I need to review
;;
;; Author: Don Thorp
;; Date  : 12 May 2022

(ns script
  (:require [cheshire.core :as json]
            [clojure.java.shell :as shell :refer [sh]]
            [clojure.string :as str]))

(def cmd (str/join "" ["gh search prs "
              "    --review-requested=\"donthorp\" "
              "    --state=open "
              "    --limit=300 "
              "    --json=\"createdAt,number,url,title,repository\""]))

(def prs (json/parse-string 
           (:out (sh "/usr/bin/env" "bash" "-c" cmd)) true))

(defn format-pr [pr]
  (format (str "- [ ] `%s` - **[#%d](%s)**"
               "\n    - %s"
               "\n    - %s\n" )
          (get-in pr [:repository :nameWithOwner])
          (:number pr)
          (:url pr)
          (:title pr)
          (:createdAt pr)))

(defn generate-markdown [s]
  (println "\n## Pull Requests to Review")

  (if (= (count s) 0)
    (println "- No pull requests to review")
    (doseq [pr s]
      (println (format-pr pr)))))

(comment
    (require '[clojure.repl :refer :all])
    (println "hello")
    (println cmd)
    (println prs)
    (dir json)
    (generate-markdown prs)
          ,)

(generate-markdown prs)
