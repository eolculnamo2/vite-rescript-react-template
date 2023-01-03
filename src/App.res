// import raw for just importing a css file
%%raw("import './App.css'")

type state = {
  rootFolder: Folders.t,
  currentFolderId: int,
  newFolderInput: string,
  newFileInput: string,
}

let initState = {
  rootFolder: {
    id: 0,
    name: "Root",
    folders: [],
    files: [],
  },
  currentFolderId: 0,
  newFolderInput: "",
  newFileInput: "",
}

type actions =
  FolderSelected(int) | NewFolderInput(string) | NewFileInput(string) | AddFolder(int) | AddFile

let reducer = (state, action) => {
  switch action {
  | FolderSelected(id) => {
      Js.log2("ID+!", id)
      {...state, currentFolderId: id}
    }

  | NewFolderInput(newText) => {...state, newFolderInput: newText}
  | NewFileInput(newText) => {...state, newFileInput: newText}
  | AddFile => state
  | AddFolder(id) => {
      ...state,
      rootFolder: Folders.addFolder(id, state.currentFolderId, state.rootFolder),
    }
  }
}

@react.component @genType
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initState)
  Js.log(state.currentFolderId)
  Js.log(state.rootFolder)
  <div className="App">
    <div>
      <label> {"New folder"->React.string} </label>
      <input
        value={state.newFolderInput}
        onChange={e => {
          ReactEvent.Form.target(e)["value"]->NewFolderInput->dispatch
        }}
      />
      <button
        type_="button"
        onClick={_ => {
          Js.log("!!")
          dispatch(AddFolder(Js.Math.random_int(1, 100000)))
        }}>
        {"Add folder"->React.string}
      </button>
    </div>
    <div>
      <label> {"New file"->React.string} </label>
      <input
        value={state.newFileInput}
        onChange={e => {
          ReactEvent.Form.target(e)["value"]->NewFileInput->dispatch
        }}
      />
      <button type_="button"> {"Add file"->React.string} </button>
    </div>
    <Folders.Folder
      folder={state.rootFolder} selectFolder={(id: int) => id->FolderSelected->dispatch}
    />
  </div>
}
