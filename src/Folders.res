type rec t = {
  id: int,
  name: string,
  folders: array<t>,
  files: array<string>,
}

let createFolder = newId => {
  id: newId,
  name: "New folder",
  folders: [],
  files: [],
}

let rec findFolderById = (targetFolderId: int, rootFolder: t): option<t> => {
  if rootFolder.id == targetFolderId {
    Some(rootFolder)
  } else if rootFolder.folders->Belt.Array.length == 0 {
    None
  } else {
    rootFolder.folders
    ->Belt.Array.map(f => findFolderById(targetFolderId, f))
    ->Js.Array2.find(f => Belt.Option.isSome(f))
    ->Belt.Option.getWithDefault(None)
  }
}
let addFolder = (newId: int, currentFolderId: int, rootFolder: t): t => {
  Js.log("??")
  let folder = findFolderById(currentFolderId, rootFolder)
  let _ = folder->Belt.Option.map(f => {
    /* let _ = f.folders->Js.Array2.push(createFolder(newId)) */
    /* f */
    {...f, folders: f.folders->Js.Array2.concat([createFolder()])}
  })
  rootFolder
}

module rec Folder: {
  let make: {"folder": t, "selectFolder": int => unit} => React.element
  let makeProps: (
    ~folder: t,
    ~selectFolder: int => unit,
    ~key: string=?,
    unit,
  ) => {"folder": t, "selectFolder": int => unit}
} = {
  @react.component
  let make = (~folder: t, ~selectFolder) => {
    <div onClick={_ => selectFolder(folder.id)}>
      {folder.name->React.string}
      {folder.folders
      ->Belt.Array.map(f => {
        <Folder key={f.id->Belt.Int.toString} folder={f} selectFolder={selectFolder} />
      })
      ->React.array}
    </div>
  }
}
