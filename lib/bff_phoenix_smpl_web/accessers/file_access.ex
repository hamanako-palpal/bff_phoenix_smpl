defmodule FileAccess do

  def get_file_Nm(:json_user), do: "./lib/bff_phoenix_smpl_web/accessers/users.json"

  def read(tag) do

    get_file_Nm(tag)
    |> File.read!
    |> Poison.decode!
    |> get_text
  end

  def get_text(%{"users"=> users}) do
    get_text(users, [])
  end

  def get_text(%{"follows"=> follows}) do
    get_text(follows, [])
  end

  def get_text(%{"graffiti"=> follows}) do
    get_text(follows, [])
  end

  def get_text([%{"id"=> id, "pw"=>pw} | tail], li) do
    li = li ++ [%User{id: id, pw: pw}]
    get_text(tail, li)
  end

  # def get_text([%{"follow_id"=> follow_id, "follower_id"=>follower_id} | tail], li) do
  #   li = li ++ [%Follow{follow_id: follow_id, follower_id: follower_id}]
  #   get_text(tail, li)
  # end

  # def get_text([%{"comment"=>comment, "id"=>id} | tail], li) do
  #   li = li ++ [%Graffiti{comment: comment, id: id}]
  #   get_text(tail, li)
  # end

  def get_text([], li) do li end


end
