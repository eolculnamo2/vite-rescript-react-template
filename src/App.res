// import raw for just importing a css file
%%raw("import './App.css'")

// import with @module for import interpo when you want to define a variable
@module("./assets/react.svg") external reactLogo: string = "default"

// @genType generates a tsx file for main.tsx to understand.
// shouldn't be needed anywhere else unless interacting with TS again
@react.component @genType
let make = () => {
  let (count, setCount) = React.useState(_ => 0)
  <div className="App">
    <div>
      <a href="https://vitejs.dev" target="_blank">
        <img src="/vite.svg" className="logo" alt="Vite logo" />
      </a>
      <a href="https://reactjs.org" target="_blank">
        <img src={reactLogo} className="logo react" alt="React logo" />
      </a>
    </div>
    <h1> {"Vite + React + ReScript"->React.string} </h1>
    <div className="card">
      <button onClick={_ => setCount(count => count + 1)}>
        {("count is " ++ Belt.Int.toString(count))->React.string}
      </button>
      <p>
        {"Edit "->React.string}
        <code> {"src/App.tsx"->React.string} </code>
        {" and save to test HMR"->React.string}
      </p>
    </div>
    <p className="read-the-docs">
      {"Click on the Vite and React logos to learn more"->React.string}
    </p>
  </div>
}
