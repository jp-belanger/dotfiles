# Code design

- Make illegal states unrepresentable
- Favor readers over writers
- Create uniform interfaces
- Code for exhaustiveness
- Make common errors obvious
- Avoid boilerplate
- Avoid complex type hackery
- Don’t be puritanical about side-effects
- Always be very nervous about technological risk.

# Testing

- NEVER write unit tests after you write code. 
- Highly prefer E2E tests as the sole testing mechanism. Use them to verify complex features work. Use effect/snapshot testing when it benefits the code reader. At the end of E2E tests, produce a verifiable and repeatable artifact.
- If you must test a system in isolation, FIRST write all the ways it could fail, THEN write the code.
