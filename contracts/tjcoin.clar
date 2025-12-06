;; title: tjcoin
;; version: 1.0.0
;; summary: TJCoin - A fungible token implementation on Stacks
;; description: TJCoin is a fungible token (SIP-010 compliant) with fixed supply,
;;              transfer capabilities, and administrative controls.

;; traits
;; Note: For production use, import the SIP-010 trait with:
;; (use-trait sip-010-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)
;; (impl-trait sip-010-trait)

;; token definitions
(define-fungible-token tjcoin u1000000000000) ;; 1 trillion tokens (with 6 decimals)

;; constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))
(define-constant err-insufficient-balance (err u102))
(define-constant err-invalid-amount (err u103))

;; data vars
(define-data-var token-name (string-ascii 32) "TJCoin")
(define-data-var token-symbol (string-ascii 10) "TJC")
(define-data-var token-uri (optional (string-utf8 256)) none)
(define-data-var token-decimals uint u6)

;; data maps
;;

;; SIP-010 Functions

;; Transfer tokens
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
  (begin
    (asserts! (or (is-eq tx-sender sender) (is-eq contract-caller sender)) err-not-token-owner)
    (asserts! (> amount u0) err-invalid-amount)
    (try! (ft-transfer? tjcoin amount sender recipient))
    (match memo to-print (print to-print) 0x)
    (ok true)
  )
)

;; Get token name
(define-read-only (get-name)
  (ok (var-get token-name))
)

;; Get token symbol
(define-read-only (get-symbol)
  (ok (var-get token-symbol))
)

;; Get token decimals
(define-read-only (get-decimals)
  (ok (var-get token-decimals))
)

;; Get balance of an account
(define-read-only (get-balance (account principal))
  (ok (ft-get-balance tjcoin account))
)

;; Get total supply
(define-read-only (get-total-supply)
  (ok (ft-get-supply tjcoin))
)

;; Get token URI
(define-read-only (get-token-uri)
  (ok (var-get token-uri))
)

;; public functions

;; Mint tokens (only contract owner)
(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (> amount u0) err-invalid-amount)
    (ft-mint? tjcoin amount recipient)
  )
)

;; Burn tokens
(define-public (burn (amount uint) (sender principal))
  (begin
    (asserts! (or (is-eq tx-sender sender) (is-eq contract-caller sender)) err-not-token-owner)
    (asserts! (> amount u0) err-invalid-amount)
    (ft-burn? tjcoin amount sender)
  )
)

;; Set token URI (only contract owner)
(define-public (set-token-uri (uri (string-utf8 256)))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (ok (var-set token-uri (some uri)))
  )
)

;; Initialize contract by minting initial supply to contract owner
(begin
  (try! (ft-mint? tjcoin u1000000000000 contract-owner))
)

