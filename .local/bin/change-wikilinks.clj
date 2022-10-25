#! /usr/bin/env bb

;; change-wikilinks
;;
;; Author: Don Thorp
;; Created: 20 Jun 2022
;;
;; In using Obsidian.md, it's not uncommon for me to need to update a wikilink
;; from one form to another (e.g. [[@FirstName LastName]] to [[@FirstName LastName|FirstName]])
;; as I decide that I want to use an alias in the link.
;;
;; Requirements
;;
;; - Take and validate that a from link and two link are provided as arguments to the script
;;     - `change-wikilinks "[[@Someone]]" "[[@Someone|alias]]"
;;     - Note: this is explicitly FROM TO by definition
;;     - Wikilinks in `[[.+]]` form are required
;;     - FROM and TO are case-sensitive
;; - Script should only work in an Obsidian.md directory (i.e. contains `.obsidian` folder)
;; - Only scan .md files
;; - Default operation should be --dry-run to start.
;; - Only changed files should be updated

(ns change-wikilinks
  (:require
   [babashka.fs :as fs]
   [clojure.java.shell :as shell :refer [sh]]
   [clojure.repl :refer :all]
   [clojure.string :as str]))

(def FROM "[[@Gemma Sole]]")
(def TO "[[@Gemma Sole|@Gemma]]")

(defn safe-exit [code]
  (if (fs/exists? ".nrepl-port") 
    (print (format "IN REPL, skipping exit with code %d\n" code))
    (System/exit code)))

(defn display-usage [] 
  (println "Usage: change-wikilinks.clj <OLD-LINK> <NEW-LINK>")
  (println "  Where <OLD-LINK> and <NEW-LINK> are wikilinks (e.g. [[link]])"))

(defn exit-with-message [code msg]
  (do
    (display-usage)
    (print "\n")
    (println msg)
    (safe-exit code)))

(defn validate-wikilink [link] 
  (boolean (->> link 
              (re-matches #"\[\[.+?\]\]"))))

(defn obsidian-vault? [] 
  (fs/exists? ".obsidian"))

(defn process-files [from to] 
  (let [pattern (str/join "" ["\"" from "\""])
        result (sh "/usr/bin/env" "bash" "-c" (str/join " " ["grep -rlF --include=*.md" pattern]))]
    (if (= (:exit result) 0)
      (doseq [fname (str/split-lines (:out result))]
        (let [contents (slurp fname)
              new-contents (str/replace contents from to)]
          (spit fname new-contents)))
      (exit-with-message 1 (format "ERROR: %s, not found in vault" from)))))

(let [args *command-line-args*]
  (when (not (= (count args) 2))
    (exit-with-message 1 "ERROR: Missing parameters"))
  (doseq [arg args]
    (when (not (validate-wikilink arg))
      (exit-with-message 1 (format "ERROR: %s is not a wikilink" arg))))
  (let [from (first args)
        to (second args)]
    (process-files from to)))

(comment 
  (validate-wiki-link FROM)
  (validate-wiki-link TO)
  (validate-wiki-link "Nope")
  (obsidian-vault?)
  (process-files FROM TO)
  (process-files "[[boink]]")
  (print (sh "/usr/bin/env" "bash" "-c" "env"))
  (def *command-line-args* nil)
  (def *command-line-args* ["bugs" "bunny"])
  (def *command-line-args* ["[[@Gemma Sole]]" "not link"])
  (def *command-line-args* ["not link" "[[@Gemma Sole|@Gemma]]"])
  (def *command-line-args* ["[[@Gemma Sole]]" "[[@Gemma Sole|@Gemma]]"])
  ,)

