defmodule Evision.Nx.Test do
  use ExUnit.Case

  @tag :nx
  test "load an image from file and convert to Nx.tensor" do
    {:ok, mat} =
      Path.join(__DIR__, ["test.png"])
      |> Evision.imread()

    t = Evision.Nx.to_nx(mat)

    shape = Nx.shape(t)
    {:ok, mat_shape} = Evision.Mat.shape(mat)
    assert shape == mat_shape

    type = Nx.type(t)
    {:ok, mat_type} = Evision.Mat.type(mat)
    assert type == mat_type

    bin = Nx.to_binary(t)
    {:ok, mat_bin} = Evision.Mat.to_binary(mat)
    assert bin == mat_bin
  end

  @tag :nx
  test "load an image, convert to tensor and convert back from tensor" do
    {:ok, mat} =
      Path.join(__DIR__, ["test.png"])
      |> Evision.imread()

    t = Evision.Nx.to_nx(mat)

    {:ok, mat} = Evision.Nx.to_mat(t)
    shape = Nx.shape(t)
    {:ok, mat_shape} = Evision.Mat.shape(mat)
    assert shape == mat_shape

    type = Nx.type(t)
    {:ok, mat_type} = Evision.Mat.type(mat)
    assert type == mat_type

    bin = Nx.to_binary(t)
    {:ok, mat_bin} = Evision.Mat.to_binary(mat)
    assert bin == mat_bin
  end

  @tag :nx
  test "convert from arbitrary tensor" do
    t = Nx.iota({2, 3, 2, 3, 2, 3}, type: {:s, 32})

    {:ok, mat} = Evision.Nx.to_mat(t)
    shape = Nx.shape(t)
    {:ok, mat_shape} = Evision.Mat.shape(mat)
    assert shape == mat_shape

    type = Nx.type(t)
    {:ok, mat_type} = Evision.Mat.type(mat)
    assert type == mat_type

    bin = Nx.to_binary(t)
    {:ok, mat_bin} = Evision.Mat.to_binary(mat)
    assert bin == mat_bin
  end

  @tag :nx
  test "expecting correct shaoe after transposing" do
    from_tensor = Evision.Nx.to_mat!(Nx.iota({4, 3, 3}, type: :f32))
    assert {4, 3, 3} = Evision.Mat.shape!(from_tensor)
    transposed = Evision.Mat.transpose!(from_tensor, [1, 0, 2])
    assert {3, 4, 3} = Evision.Mat.shape!(transposed)
  end
end
